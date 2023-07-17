// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$talkHash() => r'43ac2c0ff6372ced2df122cfe463fcab6ab7c0b8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef _TalkRef = AutoDisposeFutureProviderRef<Talk>;

/// See also [_talk].
@ProviderFor(_talk)
const _talkProvider = _TalkFamily();

/// See also [_talk].
class _TalkFamily extends Family<AsyncValue<Talk>> {
  /// See also [_talk].
  const _TalkFamily();

  /// See also [_talk].
  _TalkProvider call(
    String address,
  ) {
    return _TalkProvider(
      address,
    );
  }

  @override
  _TalkProvider getProviderOverride(
    covariant _TalkProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_talkProvider';
}

/// See also [_talk].
class _TalkProvider extends AutoDisposeFutureProvider<Talk> {
  /// See also [_talk].
  _TalkProvider(
    this.address,
  ) : super.internal(
          (ref) => _talk(
            ref,
            address,
          ),
          from: _talkProvider,
          name: r'_talkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$talkHash,
          dependencies: _TalkFamily._dependencies,
          allTransitiveDependencies: _TalkFamily._allTransitiveDependencies,
        );

  final String address;

  @override
  bool operator ==(Object other) {
    return other is _TalkProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$talkDisplayNameHash() => r'0c804df14048c53d1983cf9a77d360f791a454e4';
typedef _TalkDisplayNameRef = AutoDisposeProviderRef<String>;

/// See also [_talkDisplayName].
@ProviderFor(_talkDisplayName)
const _talkDisplayNameProvider = _TalkDisplayNameFamily();

/// See also [_talkDisplayName].
class _TalkDisplayNameFamily extends Family<String> {
  /// See also [_talkDisplayName].
  const _TalkDisplayNameFamily();

  /// See also [_talkDisplayName].
  _TalkDisplayNameProvider call(
    Talk talk,
  ) {
    return _TalkDisplayNameProvider(
      talk,
    );
  }

  @override
  _TalkDisplayNameProvider getProviderOverride(
    covariant _TalkDisplayNameProvider provider,
  ) {
    return call(
      provider.talk,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_talkDisplayNameProvider';
}

/// See also [_talkDisplayName].
class _TalkDisplayNameProvider extends AutoDisposeProvider<String> {
  /// See also [_talkDisplayName].
  _TalkDisplayNameProvider(
    this.talk,
  ) : super.internal(
          (ref) => _talkDisplayName(
            ref,
            talk,
          ),
          from: _talkDisplayNameProvider,
          name: r'_talkDisplayNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkDisplayNameHash,
          dependencies: _TalkDisplayNameFamily._dependencies,
          allTransitiveDependencies:
              _TalkDisplayNameFamily._allTransitiveDependencies,
        );

  final Talk talk;

  @override
  bool operator ==(Object other) {
    return other is _TalkDisplayNameProvider && other.talk == talk;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talk.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$accessRecipientWithPublicKeyHash() =>
    r'8cd0c92d333699019c70fa46161053c030e3e555';
typedef _AccessRecipientWithPublicKeyRef
    = AutoDisposeFutureProviderRef<AccessRecipient>;

/// See also [_accessRecipientWithPublicKey].
@ProviderFor(_accessRecipientWithPublicKey)
const _accessRecipientWithPublicKeyProvider =
    _AccessRecipientWithPublicKeyFamily();

/// See also [_accessRecipientWithPublicKey].
class _AccessRecipientWithPublicKeyFamily
    extends Family<AsyncValue<AccessRecipient>> {
  /// See also [_accessRecipientWithPublicKey].
  const _AccessRecipientWithPublicKeyFamily();

  /// See also [_accessRecipientWithPublicKey].
  _AccessRecipientWithPublicKeyProvider call(
    String pubKey,
  ) {
    return _AccessRecipientWithPublicKeyProvider(
      pubKey,
    );
  }

  @override
  _AccessRecipientWithPublicKeyProvider getProviderOverride(
    covariant _AccessRecipientWithPublicKeyProvider provider,
  ) {
    return call(
      provider.pubKey,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_accessRecipientWithPublicKeyProvider';
}

/// See also [_accessRecipientWithPublicKey].
class _AccessRecipientWithPublicKeyProvider
    extends AutoDisposeFutureProvider<AccessRecipient> {
  /// See also [_accessRecipientWithPublicKey].
  _AccessRecipientWithPublicKeyProvider(
    this.pubKey,
  ) : super.internal(
          (ref) => _accessRecipientWithPublicKey(
            ref,
            pubKey,
          ),
          from: _accessRecipientWithPublicKeyProvider,
          name: r'_accessRecipientWithPublicKeyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accessRecipientWithPublicKeyHash,
          dependencies: _AccessRecipientWithPublicKeyFamily._dependencies,
          allTransitiveDependencies:
              _AccessRecipientWithPublicKeyFamily._allTransitiveDependencies,
        );

  final String pubKey;

  @override
  bool operator ==(Object other) {
    return other is _AccessRecipientWithPublicKeyProvider &&
        other.pubKey == pubKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pubKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$remoteTalkHash() => r'ed7b1d88182f4cdacb77c6ddbb6ca827ce2ae567';
typedef _RemoteTalkRef = AutoDisposeFutureProviderRef<Talk>;

/// See also [_remoteTalk].
@ProviderFor(_remoteTalk)
const _remoteTalkProvider = _RemoteTalkFamily();

/// See also [_remoteTalk].
class _RemoteTalkFamily extends Family<AsyncValue<Talk>> {
  /// See also [_remoteTalk].
  const _RemoteTalkFamily();

  /// See also [_remoteTalk].
  _RemoteTalkProvider call(
    String address,
  ) {
    return _RemoteTalkProvider(
      address,
    );
  }

  @override
  _RemoteTalkProvider getProviderOverride(
    covariant _RemoteTalkProvider provider,
  ) {
    return call(
      provider.address,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_remoteTalkProvider';
}

/// See also [_remoteTalk].
class _RemoteTalkProvider extends AutoDisposeFutureProvider<Talk> {
  /// See also [_remoteTalk].
  _RemoteTalkProvider(
    this.address,
  ) : super.internal(
          (ref) => _remoteTalk(
            ref,
            address,
          ),
          from: _remoteTalkProvider,
          name: r'_remoteTalkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$remoteTalkHash,
          dependencies: _RemoteTalkFamily._dependencies,
          allTransitiveDependencies:
              _RemoteTalkFamily._allTransitiveDependencies,
        );

  final String address;

  @override
  bool operator ==(Object other) {
    return other is _RemoteTalkProvider && other.address == address;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$sortedTalksHash() => r'a69c62e57de2860c16c0b8d09c73490816d807a1';

/// See also [_sortedTalks].
@ProviderFor(_sortedTalks)
final _sortedTalksProvider = AutoDisposeFutureProvider<List<Talk>>.internal(
  _sortedTalks,
  name: r'_sortedTalksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortedTalksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _SortedTalksRef = AutoDisposeFutureProviderRef<List<Talk>>;
String _$messageCreationFeesHash() =>
    r'd73daff392d278e20cddfd6d6fe9e3e1d46f71e9';
typedef _MessageCreationFeesRef = AutoDisposeFutureProviderRef<double>;

/// See also [_messageCreationFees].
@ProviderFor(_messageCreationFees)
const _messageCreationFeesProvider = _MessageCreationFeesFamily();

/// See also [_messageCreationFees].
class _MessageCreationFeesFamily extends Family<AsyncValue<double>> {
  /// See also [_messageCreationFees].
  const _MessageCreationFeesFamily();

  /// See also [_messageCreationFees].
  _MessageCreationFeesProvider call(
    String talkAddress,
    String content,
  ) {
    return _MessageCreationFeesProvider(
      talkAddress,
      content,
    );
  }

  @override
  _MessageCreationFeesProvider getProviderOverride(
    covariant _MessageCreationFeesProvider provider,
  ) {
    return call(
      provider.talkAddress,
      provider.content,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_messageCreationFeesProvider';
}

/// See also [_messageCreationFees].
class _MessageCreationFeesProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_messageCreationFees].
  _MessageCreationFeesProvider(
    this.talkAddress,
    this.content,
  ) : super.internal(
          (ref) => _messageCreationFees(
            ref,
            talkAddress,
            content,
          ),
          from: _messageCreationFeesProvider,
          name: r'_messageCreationFeesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageCreationFeesHash,
          dependencies: _MessageCreationFeesFamily._dependencies,
          allTransitiveDependencies:
              _MessageCreationFeesFamily._allTransitiveDependencies,
        );

  final String talkAddress;
  final String content;

  @override
  bool operator ==(Object other) {
    return other is _MessageCreationFeesProvider &&
        other.talkAddress == talkAddress &&
        other.content == content;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);
    hash = _SystemHash.combine(hash, content.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$talkMessagesHash() => r'b145aeb4672f368d39954ad88a45cd9eee51154b';
typedef _TalkMessagesRef = AutoDisposeFutureProviderRef<List<TalkMessage>>;

/// See also [_talkMessages].
@ProviderFor(_talkMessages)
const _talkMessagesProvider = _TalkMessagesFamily();

/// See also [_talkMessages].
class _TalkMessagesFamily extends Family<AsyncValue<List<TalkMessage>>> {
  /// See also [_talkMessages].
  const _TalkMessagesFamily();

  /// See also [_talkMessages].
  _TalkMessagesProvider call(
    String talkAddress,
    int offset,
    int pageSize,
  ) {
    return _TalkMessagesProvider(
      talkAddress,
      offset,
      pageSize,
    );
  }

  @override
  _TalkMessagesProvider getProviderOverride(
    covariant _TalkMessagesProvider provider,
  ) {
    return call(
      provider.talkAddress,
      provider.offset,
      provider.pageSize,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_talkMessagesProvider';
}

/// See also [_talkMessages].
class _TalkMessagesProvider
    extends AutoDisposeFutureProvider<List<TalkMessage>> {
  /// See also [_talkMessages].
  _TalkMessagesProvider(
    this.talkAddress,
    this.offset,
    this.pageSize,
  ) : super.internal(
          (ref) => _talkMessages(
            ref,
            talkAddress,
            offset,
            pageSize,
          ),
          from: _talkMessagesProvider,
          name: r'_talkMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkMessagesHash,
          dependencies: _TalkMessagesFamily._dependencies,
          allTransitiveDependencies:
              _TalkMessagesFamily._allTransitiveDependencies,
        );

  final String talkAddress;
  final int offset;
  final int pageSize;

  @override
  bool operator ==(Object other) {
    return other is _TalkMessagesProvider &&
        other.talkAddress == talkAddress &&
        other.offset == offset &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$talksHash() => r'81be6d6bc0cd5bbdf9a1f0dbdea3712829bf8e5e';

/// See also [_Talks].
@ProviderFor(_Talks)
final _talksProvider =
    AutoDisposeAsyncNotifierProvider<_Talks, Iterable<Talk>>.internal(
  _Talks.new,
  name: r'_talksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$talksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Talks = AutoDisposeAsyncNotifier<Iterable<Talk>>;
String _$messageCreationFormNotifierHash() =>
    r'08232b825245fcdcfbc984448dca7aa6332e4776';

abstract class _$MessageCreationFormNotifier
    extends BuildlessAutoDisposeNotifier<MessageCreationFormState> {
  late final String talkAddress;

  MessageCreationFormState build(
    String talkAddress,
  );
}

/// See also [_MessageCreationFormNotifier].
@ProviderFor(_MessageCreationFormNotifier)
const _messageCreationFormNotifierProvider =
    _MessageCreationFormNotifierFamily();

/// See also [_MessageCreationFormNotifier].
class _MessageCreationFormNotifierFamily
    extends Family<MessageCreationFormState> {
  /// See also [_MessageCreationFormNotifier].
  const _MessageCreationFormNotifierFamily();

  /// See also [_MessageCreationFormNotifier].
  _MessageCreationFormNotifierProvider call(
    String talkAddress,
  ) {
    return _MessageCreationFormNotifierProvider(
      talkAddress,
    );
  }

  @override
  _MessageCreationFormNotifierProvider getProviderOverride(
    covariant _MessageCreationFormNotifierProvider provider,
  ) {
    return call(
      provider.talkAddress,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_messageCreationFormNotifierProvider';
}

/// See also [_MessageCreationFormNotifier].
class _MessageCreationFormNotifierProvider
    extends AutoDisposeNotifierProviderImpl<_MessageCreationFormNotifier,
        MessageCreationFormState> {
  /// See also [_MessageCreationFormNotifier].
  _MessageCreationFormNotifierProvider(
    this.talkAddress,
  ) : super.internal(
          () => _MessageCreationFormNotifier()..talkAddress = talkAddress,
          from: _messageCreationFormNotifierProvider,
          name: r'_messageCreationFormNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageCreationFormNotifierHash,
          dependencies: _MessageCreationFormNotifierFamily._dependencies,
          allTransitiveDependencies:
              _MessageCreationFormNotifierFamily._allTransitiveDependencies,
        );

  final String talkAddress;

  @override
  bool operator ==(Object other) {
    return other is _MessageCreationFormNotifierProvider &&
        other.talkAddress == talkAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  MessageCreationFormState runNotifierBuild(
    covariant _MessageCreationFormNotifier notifier,
  ) {
    return notifier.build(
      talkAddress,
    );
  }
}

String _$paginatedTalkMessagesNotifierHash() =>
    r'e99219c552e4a1d3a67875f97ab62c6056d639a7';

abstract class _$PaginatedTalkMessagesNotifier
    extends BuildlessAutoDisposeNotifier<PagingController<int, TalkMessage>> {
  late final String talkAddress;

  PagingController<int, TalkMessage> build(
    String talkAddress,
  );
}

/// See also [_PaginatedTalkMessagesNotifier].
@ProviderFor(_PaginatedTalkMessagesNotifier)
const _paginatedTalkMessagesNotifierProvider =
    _PaginatedTalkMessagesNotifierFamily();

/// See also [_PaginatedTalkMessagesNotifier].
class _PaginatedTalkMessagesNotifierFamily
    extends Family<PagingController<int, TalkMessage>> {
  /// See also [_PaginatedTalkMessagesNotifier].
  const _PaginatedTalkMessagesNotifierFamily();

  /// See also [_PaginatedTalkMessagesNotifier].
  _PaginatedTalkMessagesNotifierProvider call(
    String talkAddress,
  ) {
    return _PaginatedTalkMessagesNotifierProvider(
      talkAddress,
    );
  }

  @override
  _PaginatedTalkMessagesNotifierProvider getProviderOverride(
    covariant _PaginatedTalkMessagesNotifierProvider provider,
  ) {
    return call(
      provider.talkAddress,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_paginatedTalkMessagesNotifierProvider';
}

/// See also [_PaginatedTalkMessagesNotifier].
class _PaginatedTalkMessagesNotifierProvider
    extends AutoDisposeNotifierProviderImpl<_PaginatedTalkMessagesNotifier,
        PagingController<int, TalkMessage>> {
  /// See also [_PaginatedTalkMessagesNotifier].
  _PaginatedTalkMessagesNotifierProvider(
    this.talkAddress,
  ) : super.internal(
          () => _PaginatedTalkMessagesNotifier()..talkAddress = talkAddress,
          from: _paginatedTalkMessagesNotifierProvider,
          name: r'_paginatedTalkMessagesNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paginatedTalkMessagesNotifierHash,
          dependencies: _PaginatedTalkMessagesNotifierFamily._dependencies,
          allTransitiveDependencies:
              _PaginatedTalkMessagesNotifierFamily._allTransitiveDependencies,
        );

  final String talkAddress;

  @override
  bool operator ==(Object other) {
    return other is _PaginatedTalkMessagesNotifierProvider &&
        other.talkAddress == talkAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, talkAddress.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  PagingController<int, TalkMessage> runNotifierBuild(
    covariant _PaginatedTalkMessagesNotifier notifier,
  ) {
    return notifier.build(
      talkAddress,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions