import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SimpleSharedPref {
  static final SimpleSharedPref _sharedPrefHelper =
      SimpleSharedPref._internal();
  static SharedPreferences? _instance;
  final String _className = 'SharedPreferenceHelper: ';

  SimpleSharedPref._internal();

  factory SimpleSharedPref() {
    return _sharedPrefHelper;
  }

  init() async {
    if (_instance == null) _instance = await SharedPreferences.getInstance();
  }

  SharedPreferences? get pref => _instance;

  int? getInt({required String key}) {
    try {
      if (contain(key: key)) {
        return pref!.getInt(_getLastStringOfEnum(key));
      }
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while getting int from shared: ',
          error: e);
    }
    return null;
  }

  String? getString({required key}) {
    try {
      if (contain(key: key))
        return pref!.getString(_getLastStringOfEnum(key));
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while getting string from shared: ',
          error: e);
    }
    return null;
  }

  double? getDouble({required key}) {
    try {
      if (contain(key: key))
        return pref!.getDouble(_getLastStringOfEnum(key));
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while getting double from shared: ',
          error: e);
    }
    return null;
  }

  bool? getBool({required key}) {
    try {
      if (contain(key: key))
        return pref!.getBool(_getLastStringOfEnum(key));
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while getting bool from shared: ',
          error: e);
    }
    return null;
  }

  List<String>? getStringList({required key}) {
    try {
      if (contain(key: key))
        return pref!.getStringList(_getLastStringOfEnum(key));
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while getting string list from shared: ',
          error: e);
    }
    return null;
  }

  Future<bool> setInt({required int value, required String key}) {
    try {
      return pref!.setInt(_getLastStringOfEnum(key), value);
    } catch (e) {
      _logExceptionByDeveloper(_className, 'Error while set int to shared: ',
          error: e);
      return Future.value(false);
    }
  }

  Future<bool> setBool({required bool value, required String key}) {
    try {
      return pref!.setBool(_getLastStringOfEnum(key), value);
    } catch (e) {
      _logExceptionByDeveloper(_className, 'Error while set bool to shared: ',
          error: e);
      return Future.value(false);
    }
  }

  Future<bool> setDouble({required double value, required String key}) {
    try {
      return pref!.setDouble(_getLastStringOfEnum(key), value);
    } catch (e) {
      _logExceptionByDeveloper(_className, 'Error while set double to shared: ',
          error: e);
      return Future.value(false);
    }
  }

  Future<bool> setString({required String value, required String key}) {
    Future<bool> _setStringFuture = Future.value(false);
    try {
      _setStringFuture = pref!.setString(_getLastStringOfEnum(key), value);
    } catch (e) {
      _logExceptionByDeveloper(_className, 'Error while set string to shared: ',
          error: e);
    }
    return _setStringFuture;
  }

  Future<bool> setStringList(
      {required List<String> value, required String key}) {
    try {
      return pref!.setStringList(_getLastStringOfEnum(key), value);
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while set string list to shared: ',
          error: e);
      return Future.value(false);
    }
  }

  bool contain({required String key}) {
    try {
      return pref!.containsKey(_getLastStringOfEnum(key));
    } catch (e) {
      _logExceptionByDeveloper(
          _className, 'Error while check exist in shared: ',
          error: e);
    }
    return false;
  }

  String _getLastStringOfEnum(String key) {
    try {
      return key.toString().split('.').last;
    } catch (e) {
      return key;
    }
  }

  void _logExceptionByDeveloper(String name, String message,
      {dynamic error, StackTrace? stackTrace}) {
    developer.log(message, name: name, error: error, stackTrace: stackTrace);
  }
}
