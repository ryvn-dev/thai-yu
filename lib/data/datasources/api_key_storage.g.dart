// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$secureStorageHash() => r'db6c9f3b2c0f5615fcf2b7d1451ea65c67256082';

/// See also [secureStorage].
@ProviderFor(secureStorage)
final secureStorageProvider = Provider<FlutterSecureStorage>.internal(
  secureStorage,
  name: r'secureStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$secureStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SecureStorageRef = ProviderRef<FlutterSecureStorage>;
String _$apiKeyNotifierHash() => r'344e19c05983a9aca10c0b42caeddb33097743c8';

/// See also [ApiKeyNotifier].
@ProviderFor(ApiKeyNotifier)
final apiKeyNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ApiKeyNotifier, String?>.internal(
      ApiKeyNotifier.new,
      name: r'apiKeyNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$apiKeyNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ApiKeyNotifier = AutoDisposeAsyncNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
