part of 'settings_drawer.dart';

class CustomizationMenuView extends StatelessWidget {
  const CustomizationMenuView({
    required this.onClose,
    super.key,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            theme.drawerBackground!,
            theme.backgroundDark!,
          ],
          begin: Alignment.center,
          end: const Alignment(5, 0),
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //Back button
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        child: BackButton(
                          key: const Key('back'),
                          color: theme.text,
                          onPressed: onClose,
                        ),
                      ),
                      Text(
                        localizations.customHeader,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                          context,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: const EdgeInsets.only(top: 15),
                    children: <Widget>[
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            localizations.preferences,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValueWithInfos(
                        heading: localizations.changeCurrencyHeader,
                        info: localizations.changeCurrencyDesc.replaceAll(
                          '%1',
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel(),
                        ),
                        defaultMethod: StateContainer.of(context).curCurrency,
                        icon: 'assets/icons/menu/currency.svg',
                        iconColor: theme.iconDrawer!,
                        onPressed: () => CurrencyDialog.getDialog(context),
                        disabled: false,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.primaryCurrency,
                        defaultMethod:
                            StateContainer.of(context).curPrimaryCurrency,
                        icon: 'assets/icons/menu/primary-currency.svg',
                        iconColor: theme.iconDrawer!,
                        onPressed: () =>
                            PrimaryCurrencyDialog.getDialog(context),
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.language,
                        defaultMethod: StateContainer.of(context).curLanguage,
                        icon: 'assets/icons/menu/language.svg',
                        iconColor: theme.iconDrawer!,
                        onPressed: () => LanguageDialog.getDialog(context),
                      ),
                      const _SettingsListItem.spacer(),
                      const _ThemeSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ShowBalancesSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ShowBlogSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ShowPriceChartSettingsListItem(),
                      // TODO(Chralu): mettre cette expression booleenne dans un provider DeviceCapabilities.notifications
                      if (!kIsWeb &&
                          (Platform.isIOS == true ||
                              Platform.isAndroid == true ||
                              Platform.isMacOS == true))
                        const _SettingsListItem.spacer(),
                      if (!kIsWeb &&
                          (Platform.isIOS == true ||
                              Platform.isAndroid == true ||
                              Platform.isMacOS == true))
                        const _ActiveNotificationsSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ActiveVibrationsSettingsListItem(),
                      const _SettingsListItem.spacer(),
                    ],
                  ),
                  //List Top Gradient End
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            theme.drawerBackground!,
                            theme.backgroundDark00!
                          ],
                          begin: const AlignmentDirectional(0.5, -1),
                          end: const AlignmentDirectional(0.5, 1),
                        ),
                      ),
                    ),
                  ), //List Top Gradient End
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSettingsListItem extends ConsumerWidget {
  const _ThemeSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    final themeSetting =
        ref.watch(preferenceProvider.select((settings) => settings.theme));
    final preferencesNotifier = ref.read(preferenceProvider.notifier);
    return _SettingsListItem.withDefaultValue(
      heading: localizations.themeHeader,
      defaultMethod: ThemeSetting(themeSetting),
      icon: 'assets/icons/menu/theme.svg',
      iconColor: theme.iconDrawer!,
      onPressed: () async {
        final pickedTheme =
            await ThemeDialog.getDialog(context, ThemeSetting(themeSetting));
        if (pickedTheme == null) return;
        await preferencesNotifier.setTheme(pickedTheme);
      },
    );
  }
}

class _ShowBalancesSettingsListItem extends ConsumerWidget {
  const _ShowBalancesSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    final showBalancesSetting = ref
        .watch(preferenceProvider.select((settings) => settings.showBalances));
    final preferencesNotifier = ref.read(preferenceProvider.notifier);
    return _SettingsListItem.withSwitch(
      heading: localizations.showBalances,
      icon: 'assets/icons/menu/show-balance.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: showBalancesSetting,
      onChanged: (showBalances) async {
        await preferencesNotifier.setShowBalances(showBalances);
        StateContainer.of(context).showBalance = showBalances;
      },
    );
  }
}

class _ShowBlogSettingsListItem extends ConsumerWidget {
  const _ShowBlogSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    final showBlogSetting =
        ref.watch(preferenceProvider.select((settings) => settings.showBlog));
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showBlog,
      icon: 'assets/icons/menu/show-blog.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: showBlogSetting,
      onChanged: (showBlog) async {
        await preferencesNotifier.setShowBlog(showBlog);
        StateContainer.of(context).showBlog = showBlog;
      },
    );
  }
}

class _ShowPriceChartSettingsListItem extends ConsumerWidget {
  const _ShowPriceChartSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    final showPriceChart = ref.watch(
      preferenceProvider.select((settings) => settings.showPriceChart),
    );
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showPriceChart,
      icon: 'assets/icons/menu/show-chart.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: showPriceChart,
      onChanged: (showPriceChart) async {
        await preferencesNotifier.setShowPriceChart(showPriceChart);
        StateContainer.of(context).showPriceChart = showPriceChart;
      },
    );
  }
}

class _ActiveNotificationsSettingsListItem extends ConsumerWidget {
  const _ActiveNotificationsSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    final activeNotifications = ref.watch(
      preferenceProvider.select((settings) => settings.activeNotifications),
    );
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateNotifications,
      icon: 'assets/icons/menu/notification.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: activeNotifications,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveNotifications(isSwitched);

        StateContainer.of(context).activeNotifications = isSwitched;
        if (StateContainer.of(context).timerCheckTransactionInputs != null) {
          StateContainer.of(context).timerCheckTransactionInputs!.cancel();
        }
        if (isSwitched) {
          StateContainer.of(context).checkTransactionInputs(
            localizations.transactionInputNotification,
          );
        }
      },
    );
  }
}

class _ActiveVibrationsSettingsListItem extends ConsumerWidget {
  const _ActiveVibrationsSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    final activeVibrations = ref.watch(
      preferenceProvider.select((settings) => settings.activeVibrations),
    );
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateVibrations,
      icon: 'assets/icons/menu/vibration.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: activeVibrations,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveVibrations(isSwitched);
        StateContainer.of(context).activeVibrations = isSwitched;
      },
    );
  }
}