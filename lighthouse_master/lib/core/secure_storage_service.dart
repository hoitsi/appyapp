import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // --- Specific Keys ---
  
  Future<void> setProStatus(bool isPro) async {
    await save('is_pro_user', isPro.toString());
  }

  Future<bool> getProStatus() async {
    final val = await read('is_pro_user');
    return val == 'true';
  }
}
