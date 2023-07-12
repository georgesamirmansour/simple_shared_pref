import 'package:encrypt/encrypt.dart';

/// @see CryptoModule is class to allow shared pref
class CryptoModule {
  /// Encrypts the provided [data] using the AES encryption algorithm and the given [key].
  /// Returns the encrypted data as a base64-encoded string.
  ///
  /// The [key] should be a valid encryption key used for encryption and decryption.
  /// Make sure to keep the encryption key secure.
  String encryptData(String data, String key) {
    final encrypter = Encrypter(AES(Key.fromUtf8(key)));
    final encrypted = encrypter.encrypt(data);
    return encrypted.base64;
  }

  /// Decrypts the provided [encryptedData] using the AES encryption algorithm and the given [key].
  /// Returns the decrypted data as a string.
  ///
  /// The [key] should be the same encryption key used for encryption.
  /// Make sure to keep the encryption key secure.
  String decryptData(String encryptedData, String key) {
    final encrypter = Encrypter(AES(Key.fromUtf8(key)));
    final decrypted = encrypter.decrypt64(encryptedData);
    return decrypted;
  }
}
