import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  static late final FlutterSecureStorage _storage;

  static Future<void> init() async {
    _storage = const FlutterSecureStorage();
  }

  Future<void> saveData(String key, dynamic value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<T?> getData<T>(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    if (T == String) return value as T;
    if (T == int) return int.tryParse(value) as T?;
    if (T == double) return double.tryParse(value) as T?;
    if (T == bool) return (value == 'true') as T;
    return null;
  }

  Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<bool> containsKey(String key) async {
    final value = await _storage.read(key: key);
    return value != null;
  }
}
