import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterPassword extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isMasterPrznt = false;

  void init() async {
    await isMasterPassAvilable();
  }

  // check if masterpassword is available or not....
  Future<bool> isMasterPassAvilable() async {
    final SharedPreferences prefs = await _prefs;
    int master = prefs.getInt('master-password') ?? 0;
    if (master != 0) {
      isMasterPrznt = true;
      return true;
    }
    isMasterPrznt = false;
    return false;
  }

  // set masterpassword if not available...
  Future<bool> setMasterPass(int pass) async {
    final SharedPreferences prefs = await _prefs;
    bool isSet = await prefs.setInt("master-password", pass);
    if (isSet) {
      notifyListeners();
      return true;
    }
    return false;
  }

  // check id master key is prznt thn auto login inside...
  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await _prefs;
    if (!prefs.containsKey('master-password')) {
      return false;
    }
    isMasterPrznt = true;
    notifyListeners();
    return true;
  }

  // validate master key
  Future<bool> validateMaster(String key) async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getInt("master-password").toString() == key) {
      return true;
    }
    notifyListeners();
    return false;
  }
}
