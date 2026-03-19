import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_key_storage.g.dart';

const _kOpenAiApiKey = 'openai_api_key';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
}

@riverpod
class ApiKeyNotifier extends _$ApiKeyNotifier {
  @override
  Future<String?> build() async {
    final storage = ref.watch(secureStorageProvider);
    return storage.read(key: _kOpenAiApiKey);
  }

  Future<void> setApiKey(String key) async {
    final storage = ref.read(secureStorageProvider);
    await storage.write(key: _kOpenAiApiKey, value: key);
    ref.invalidateSelf();
  }

  Future<void> clearApiKey() async {
    final storage = ref.read(secureStorageProvider);
    await storage.delete(key: _kOpenAiApiKey);
    ref.invalidateSelf();
  }
}
