import 'dart:convert';

import 'package:registration_app/models/pref_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [SharedPreferencesUtils] includes all the util methods needed for Retriving,Storing data from and into the Phone Database.
/// Retriving - getBoolPrefs, getIntPrefs, getStringPrefs, getDoublePrefs, getMapPrefs.
/// Storing - addStringPrefs, addDoublePrefs, addIntPrefs, addBoolPrefs, addMapPrefs.
/// Clearing / Deleting - clearAllPrefs, removePrefs.
/// check validity - checkForPrefValidity / checkStatus.
/// Use [SharedPreferencesUtils] like this:
///   ```dart
///   await SharedPreferencesUtils().addBoolPrefs('isAlreadyInstalled', true);
///   PrefStatus isAlreadyInstalled = await SharedPreferencesUtils().getBoolPrefs('isAlreadyInstalled');
///   ```
///
class SharedPreferencesUtils {
  Future<bool> clearAllPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.clear();
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> checkStatus(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(prefName);
  }

  bool checkForPrefValidity(SharedPreferences prefs, String prefName) {
    return prefs.containsKey(prefName);
  }

  // remove prefs
  Future<bool> removePrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return false;
    }
    await prefs.remove(prefName);
    return true;
  }

  // add prefs
  Future<void> addStringPrefs(String prefName, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefName, value);
  }

  Future<void> addDoublePrefs(String prefName, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(prefName, value);
  }

  Future<void> addIntPrefs(String prefName, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(prefName, value);
  }

  Future<void> addBoolPrefs(String prefName, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefName, value);
  }

  Future<void> addMapPrefs(String prefName, Map<String, dynamic> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefName, json.encode(value));
  }

  // get bool refs
  Future<PrefStatus> getBoolPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefStatus(status: false, value: null);
    }
    dynamic value = prefs.getBool(prefName);
    return PrefStatus(status: true, value: value);
  }

  // get int refs
  Future<PrefStatus> getIntPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefStatus(status: false, value: null);
    }
    dynamic value = prefs.getInt(prefName);
    return PrefStatus(status: true, value: value);
  }

  // get string refs
  Future<PrefStatus> getStringPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefStatus(status: false, value: null);
    }
    dynamic value = prefs.getString(prefName);
    return PrefStatus(status: true, value: value);
  }

  // get double refs
  Future<PrefStatus> getDoublePrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefStatus(status: false, value: null);
    }
    dynamic value = prefs.getDouble(prefName);
    return PrefStatus(status: true, value: value);
  }

  // get map prefs
  Future<PrefStatus> getMapPrefs(String prefName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool validPref = checkForPrefValidity(prefs, prefName);
    if (!validPref) {
      return const PrefStatus(status: false, value: null);
    }
    String? value = prefs.getString(prefName);
    if (value == '' || value == null) {
      return const PrefStatus(status: false, value: null);
    }
    return PrefStatus(status: true, value: json.decode(value));
  }
}
