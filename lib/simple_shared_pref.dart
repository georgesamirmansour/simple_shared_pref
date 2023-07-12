import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

import 'crypto_module.dart';

/// The `SimpleSharedPref` class provides easy access to shared preferences in Flutter.
/// It follows the singleton design pattern.
class SimpleSharedPref {
  static final SimpleSharedPref _instance = SimpleSharedPref._internal();
  static SharedPreferences? _preferences;
  static late final CryptoModule? _cryptoModule;

  SimpleSharedPref._internal();

  /// Creates an instance of the `SimpleSharedPref` class.
  ///
  /// The `SimpleSharedPref` class follows the singleton design pattern, ensuring that only one instance
  /// of the class is created throughout the application.
  factory SimpleSharedPref() {
    _cryptoModule = CryptoModule();
    return _instance;
  }

  /// Initializes the shared preferences instance.
  ///
  /// The [allowEncryptAndDecrypt] parameter indicates whether encryption and decryption should be allowed with shared preferences.
  /// By default, encryption and decryption are enabled.
  Future<void> init({bool allowEncryptAndDecrypt = true}) async {
    _preferences ??= await SharedPreferences.getInstance();
    if (allowEncryptAndDecrypt) {
      _cryptoModule = CryptoModule();
    }
  }

  /// Retrieves a value from the shared preferences based on the provided [key].
  ///
  /// Returns the value if it exists, otherwise returns null.
  ///
  /// The [key] parameter represents the key associated with the value to retrieve from shared preferences.
  ///
  /// Example:
  /// ```dart
  /// String? username = SimpleSharedPref().getValue<String>('username');
  /// ```
  T? getValue<T>({required dynamic key}) {
    try {
      if (_preferences!.containsKey(key.toString())) {
        var value = _preferences!.get(key.toString());
        if (_cryptoModule != null && value is String) {
          return _cryptoModule!.decryptData(value, key.toString()) as T?;
        }
        return value as T?;
      }
    } catch (e) {
      _logException('Error while getting value from shared preferences',
          error: e);
    }
    return null;
  }

  /// Sets a value in the shared preferences with the provided [key] and [value].
  ///
  /// Returns a future indicating whether the operation was successful or not.
  ///
  /// The [key] parameter represents the key associated with the value to store in shared preferences.
  /// The [value] parameter represents the value to be stored.
  ///
  /// Example:
  /// ```dart
  /// await SimpleSharedPref().setValue('username', 'JohnDoe');
  /// ```
  Future<bool> setValue<T>({required dynamic key, required T value}) {
    try {
      if (_cryptoModule != null && value is String) {
        value = _cryptoModule!.encryptData(value, key.toString()) as T;
        return _preferences!.setString(key.toString(), value as String);
      } else if (value is String) {
        return _preferences!.setString(key.toString(), value);
      } else if (value is int) {
        return _preferences!.setInt(key.toString(), value);
      } else if (value is bool) {
        return _preferences!.setBool(key.toString(), value);
      } else if (value is double) {
        return _preferences!.setDouble(key.toString(), value);
      } else {
        return _preferences!
            .setStringList(key.toString(), value as List<String>);
      }
    } catch (e) {
      _logException('Error while setting value to shared preferences',
          error: e);
      return Future.value(false);
    }
  }

  /// Checks if a value exists in the shared preferences based on the provided [key].
  ///
  /// Returns true if the value exists, otherwise returns false.
  ///
  /// The [key] parameter represents the key associated with the value to check in shared preferences.
  ///
  /// Example:
  /// ```dart
  /// bool exists = SimpleSharedPref().containsKey('username');
  /// ```
  bool containsKey(dynamic key) {
    try {
      return _preferences!.containsKey(key.toString());
    } catch (e) {
      _logException('Error while checking existence in shared preferences',
          error: e);
    }
    return false;
  }

  /// Removes a value from the shared preferences based on the provided [key].
  ///
  /// Returns a future indicating whether the operation was successful or not.
  ///
  /// The [key] parameter represents the key associated with the value to remove from shared preferences.
  ///
  /// Example:
  /// ```dart
  /// await SimpleSharedPref().removeValue('username');
  /// ```
  Future<bool> removeValue(dynamic key) {
    try {
      return _preferences!.remove(key.toString());
    } catch (e) {
      _logException('Error while removing value from shared preferences',
          error: e);
      return Future.value(false);
    }
  }

  /// Clears all values in the shared preferences.
  ///
  /// Returns a future indicating whether the operation was successful or not.
  ///
  /// Example:
  /// ```dart
  /// await SimpleSharedPref().clear();
  /// ```
  Future<bool> clear() {
    try {
      return _preferences!.clear();
    } catch (e) {
      _logException('Error while clearing shared preferences', error: e);
      return Future.value(false);
    }
  }

  /// Logs exceptions using the developer logger.
  void _logException(String message, {dynamic error, StackTrace? stackTrace}) {
    developer.log(message, error: error, stackTrace: stackTrace);
  }
}
