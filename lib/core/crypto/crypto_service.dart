import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// PIN and backup cryptography helpers. Never log outputs from this class.
class CryptoService {
  static const pinAlgo = 'pbkdf2-sha256-120000';
  static const backupFormatVersion = '1';
  static const _pinIterations = 120000;
  static const _backupIterations = 150000;

  final _random = Random.secure();

  Uint8List randomBytes(int length) {
    final bytes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  String toBase64(Uint8List bytes) => base64Encode(bytes);

  Uint8List fromBase64(String value) => Uint8List.fromList(base64Decode(value));

  String hashPin({required String pin, required Uint8List salt}) {
    final derived = _pbkdf2(
      password: utf8.encode(pin),
      salt: salt,
      iterations: _pinIterations,
      length: 32,
    );
    return toBase64(derived);
  }

  bool verifyPin({
    required String pin,
    required String saltBase64,
    required String expectedHashBase64,
  }) {
    final salt = fromBase64(saltBase64);
    final actual = hashPin(pin: pin, salt: salt);
    return _constantTimeEquals(actual, expectedHashBase64);
  }

  /// Encrypts [plaintext] with a key derived from [password].
  /// Returns a portable package map (metadata + ciphertext only).
  Map<String, Object> encryptBackup({
    required Uint8List plaintext,
    required String password,
  }) {
    final salt = randomBytes(16);
    final iv = randomBytes(12);
    final key = _pbkdf2(
      password: utf8.encode(password),
      salt: salt,
      iterations: _backupIterations,
      length: 32,
    );
    final cipher = GCMBlockCipher(AESEngine())
      ..init(true, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));
    final cipherText = cipher.process(plaintext);
    // Zero sensitive material where practical.
    key.fillRange(0, key.length, 0);

    return {
      'formatVersion': backupFormatVersion,
      'kdf': 'pbkdf2-sha256',
      'iterations': _backupIterations,
      'salt': toBase64(salt),
      'iv': toBase64(iv),
      'ciphertext': toBase64(cipherText),
      'createdAt': DateTime.now().toUtc().toIso8601String(),
    };
  }

  Uint8List decryptBackup({
    required Map<String, dynamic> package,
    required String password,
  }) {
    final version = package['formatVersion']?.toString();
    if (version != backupFormatVersion) {
      throw StateError('incompatible');
    }
    final iterations = package['iterations'] as int? ?? _backupIterations;
    final salt = fromBase64(package['salt'] as String);
    final iv = fromBase64(package['iv'] as String);
    final cipherBytes = fromBase64(package['ciphertext'] as String);
    final key = _pbkdf2(
      password: utf8.encode(password),
      salt: salt,
      iterations: iterations,
      length: 32,
    );
    try {
      final cipher = GCMBlockCipher(AESEngine())
        ..init(false, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));
      return cipher.process(cipherBytes);
    } finally {
      key.fillRange(0, key.length, 0);
    }
  }

  String sha256Hex(Uint8List bytes) => sha256.convert(bytes).toString();

  Uint8List _pbkdf2({
    required List<int> password,
    required Uint8List salt,
    required int iterations,
    required int length,
  }) {
    final params = Pbkdf2Parameters(salt, iterations, length);
    final derivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(params);
    return derivator.process(Uint8List.fromList(password));
  }

  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}
