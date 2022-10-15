// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $_contactRepositoryHash() => r'cf712b6cccb80060dda6cf8b5e0115332d394211';

/// See also [_contactRepository].
final _contactRepositoryProvider = AutoDisposeProvider<ContactRepository>(
  _contactRepository,
  name: r'_contactRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_contactRepositoryHash,
);
typedef _ContactRepositoryRef = AutoDisposeProviderRef<ContactRepository>;
String $_fetchContactsHash() => r'e577c0c6beecb77d4217b611093c1e6f9e62b8e2';

/// See also [_fetchContacts].
class _FetchContactsProvider extends AutoDisposeFutureProvider<List<Contact>> {
  _FetchContactsProvider({
    this.search = '',
  }) : super(
          (ref) => _fetchContacts(
            ref,
            search: search,
          ),
          from: _fetchContactsProvider,
          name: r'_fetchContactsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_fetchContactsHash,
        );

  final String search;

  @override
  bool operator ==(Object other) {
    return other is _FetchContactsProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _FetchContactsRef = AutoDisposeFutureProviderRef<List<Contact>>;

/// See also [_fetchContacts].
final _fetchContactsProvider = _FetchContactsFamily();

class _FetchContactsFamily extends Family<AsyncValue<List<Contact>>> {
  _FetchContactsFamily();

  _FetchContactsProvider call({
    String search = '',
  }) {
    return _FetchContactsProvider(
      search: search,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Contact>> getProviderOverride(
    covariant _FetchContactsProvider provider,
  ) {
    return call(
      search: provider.search,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_fetchContactsProvider';
}

String $_saveContactHash() => r'618ffd2195caf59b253a4866ef3c259e29ddcba9';

/// See also [_saveContact].
class _SaveContactProvider extends AutoDisposeFutureProvider<void> {
  _SaveContactProvider({
    this.contact,
  }) : super(
          (ref) => _saveContact(
            ref,
            contact: contact,
          ),
          from: _saveContactProvider,
          name: r'_saveContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_saveContactHash,
        );

  final Contact? contact;

  @override
  bool operator ==(Object other) {
    return other is _SaveContactProvider && other.contact == contact;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contact.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _SaveContactRef = AutoDisposeFutureProviderRef<void>;

/// See also [_saveContact].
final _saveContactProvider = _SaveContactFamily();

class _SaveContactFamily extends Family<AsyncValue<void>> {
  _SaveContactFamily();

  _SaveContactProvider call({
    Contact? contact,
  }) {
    return _SaveContactProvider(
      contact: contact,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant _SaveContactProvider provider,
  ) {
    return call(
      contact: provider.contact,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_saveContactProvider';
}

String $_deleteContactHash() => r'2e752a050b11741ff8e7b5ace2b5688b5b0bfea9';

/// See also [_deleteContact].
class _DeleteContactProvider extends AutoDisposeFutureProvider<void> {
  _DeleteContactProvider({
    this.contact,
  }) : super(
          (ref) => _deleteContact(
            ref,
            contact: contact,
          ),
          from: _deleteContactProvider,
          name: r'_deleteContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_deleteContactHash,
        );

  final Contact? contact;

  @override
  bool operator ==(Object other) {
    return other is _DeleteContactProvider && other.contact == contact;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contact.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef _DeleteContactRef = AutoDisposeFutureProviderRef<void>;

/// See also [_deleteContact].
final _deleteContactProvider = _DeleteContactFamily();

class _DeleteContactFamily extends Family<AsyncValue<void>> {
  _DeleteContactFamily();

  _DeleteContactProvider call({
    Contact? contact,
  }) {
    return _DeleteContactProvider(
      contact: contact,
    );
  }

  @override
  AutoDisposeFutureProvider<void> getProviderOverride(
    covariant _DeleteContactProvider provider,
  ) {
    return call(
      contact: provider.contact,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_deleteContactProvider';
}