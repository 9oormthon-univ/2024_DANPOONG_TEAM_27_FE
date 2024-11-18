import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final Provider<StorageService> storageServiceProvider =
    Provider<StorageService>(
  (ProviderRef<StorageService> ref) => StorageService(),
);

class StorageService {
  // 싱글턴 패턴
  factory StorageService() => _instance;

  StorageService._();

  static final StorageService _instance = StorageService._();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<String?> getString({required String key}) async =>
      _secureStorage.read(key: key);

  Future<void> setString({
    required String key,
    required String value,
  }) async =>
      _secureStorage.write(key: key, value: value);

  Future<void> clear({
    required String key,
  }) async =>
      _secureStorage.delete(key: key);

  Future<void> clearAll() async => _secureStorage.deleteAll();
}
