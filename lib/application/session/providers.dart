part of 'session.dart';

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  final _appWalletDatasource = AppWalletHiveDatasource.instance();

  @override
  Session build() {
    return const Session.loggedOut();
  }

  Future<void> restore() async {
    if (!await KeychainInfoVaultDatasource.boxExists) {
      await logout();
      return;
    }

    final vault = await KeychainInfoVaultDatasource.getInstance();
    final seed = vault.getSeed();
    var keychainSecuredInfos = vault.getKeychainSecuredInfos();
    if (keychainSecuredInfos == null && seed != null) {
      // Create manually Keychain
      final keychain = await sl.get<ApiService>().getKeychain(seed);
      keychainSecuredInfos = keychain.toKeychainSecuredInfos();
      await vault.setKeychainSecuredInfos(keychainSecuredInfos);
    }
    final appWalletDTO = await _appWalletDatasource.getAppWallet();

    if (seed == null || appWalletDTO == null) {
      await logout();
      return;
    }

    state = Session.loggedIn(
      wallet: appWalletDTO.toModel(
        seed: seed,
        keychainSecuredInfos: keychainSecuredInfos!,
      ),
    );
  }

  Future<void> refresh() async {
    if (state.isLoggedOut) return;
    final connectivityStatusProvider = ref.read(connectivityStatusProviders);
    if (connectivityStatusProvider == ConnectivityStatus.isDisconnected) {
      return;
    }

    final loggedInState = state.loggedIn!;

    try {
      final keychain =
          await sl.get<ApiService>().getKeychain(loggedInState.wallet.seed);

      final keychainSecuredInfos = keychain.toKeychainSecuredInfos();

      final vault = await KeychainInfoVaultDatasource.getInstance();
      await vault.setKeychainSecuredInfos(keychainSecuredInfos);

      final newWalletDTO = await KeychainUtil().getListAccountsFromKeychain(
        keychain,
        HiveAppWalletDTO.fromModel(loggedInState.wallet),
      );
      if (newWalletDTO == null) return;

      state = Session.loggedIn(
        wallet: loggedInState.wallet.copyWith(
          keychainSecuredInfos: keychainSecuredInfos,
          appKeychain: newWalletDTO.appKeychain,
        ),
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> logout() async {
    await ref.read(SettingsProviders.settings.notifier).reset();
    await AuthenticationProviders.reset(ref);
    await ContactProviders.reset(ref);

    await KeychainInfoVaultDatasource.clear();
    await _appWalletDatasource.clearAppWallet();
    await CacheManagerHive.clear();
    await Vault.instance().clearSecureKey();

    state = const Session.loggedOut();
  }

  Future<void> createNewAppWallet({
    required String seed,
    required String keychainAddress,
    required Keychain keychain,
    String? name,
  }) async {
    final newAppWalletDTO = await HiveAppWalletDTO.createNewAppWallet(
      keychainAddress,
      keychain,
      name,
    );

    final keychainSecuredInfos = keychain.toKeychainSecuredInfos();

    final vault = await KeychainInfoVaultDatasource.getInstance();
    await vault.setSeed(seed);
    await vault.setKeychainSecuredInfos(keychainSecuredInfos);

    state = Session.loggedIn(
      wallet: newAppWalletDTO.toModel(
        seed: seed,
        keychainSecuredInfos: keychainSecuredInfos,
      ),
    );
  }

  Future<LoggedInSession?> restoreFromMnemonics({
    required List<String> mnemonics,
    required String languageCode,
  }) async {
    await _appWalletDatasource.clearAppWallet();

    final seed = AppMnemomics.mnemonicListToSeed(
      mnemonics,
      languageCode: languageCode,
    );
    if (seed.isEmpty) {
      return null;
    }
    final vault = await KeychainInfoVaultDatasource.getInstance();

    await vault.setSeed(seed);

    try {
      final keychain = await sl.get<ApiService>().getKeychain(seed);

      final appWallet = await KeychainUtil().getListAccountsFromKeychain(
        keychain,
        null,
      );

      if (appWallet == null) {
        return null;
      }

      final keychainSecuredInfos = keychain.toKeychainSecuredInfos();

      await vault.setKeychainSecuredInfos(keychainSecuredInfos);

      return state = LoggedInSession(
        wallet: appWallet.toModel(
          seed: seed,
          keychainSecuredInfos: keychainSecuredInfos,
        ),
      );
    } catch (e) {
      return null;
    }
  }
}
