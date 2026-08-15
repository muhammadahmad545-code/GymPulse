import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/errors/app_exception.dart';
import '../../core/security/secure_store.dart';

/// Android Keystore-backed store (EncryptedSharedPreferences).
class KeystoreSecureStore implements SecureStore {
  KeystoreSecureStore({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
            iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked),
          );

  final FlutterSecureStorage _storage;

  @override
  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.internalUnexpected,
        message: 'Could not store a secret securely on this device.',
        cause: e,
        retryable: true,
      );
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.internalUnexpected,
        message: 'Could not read secure device storage.',
        cause: e,
        retryable: true,
      );
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.internalUnexpected,
        message: 'Could not update secure device storage.',
        cause: e,
        retryable: true,
      );
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw AppException(
        code: AppErrorCodes.internalUnexpected,
        message: 'Could not clear secure device storage.',
        cause: e,
        retryable: true,
      );
    }
  }
}
