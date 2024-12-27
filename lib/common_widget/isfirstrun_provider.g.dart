// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isfirstrun_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'3a9f8412df34c1653d08100c9826aa2125b80f7f';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$firstRunStateHash() => r'e256e8cae3afbd34621fc18ce4a0778f35661eea';

/// See also [FirstRunState].
@ProviderFor(FirstRunState)
final firstRunStateProvider =
    AutoDisposeAsyncNotifierProvider<FirstRunState, bool>.internal(
  FirstRunState.new,
  name: r'firstRunStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firstRunStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FirstRunState = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
