import 'package:flutter/material.dart';
import 'package:kunjika/services/password_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPasswords extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<PasswordModel> passwords = [];

  Future<void> loadData() async {
    print("loading whn poppong");
    final SharedPreferences prefs = await _prefs;

    Set<String> allEntries = prefs.getKeys();
    allEntries.forEach((key) {
      passwords.add(PasswordModel(
        websiteName: key,
      ));
    });
    notifyListeners();
  }

  // add new password
  Future<bool> addNewData({String webName, String userId, String pass}) async {
    final SharedPreferences prefs = await _prefs;
    if (webName.isEmpty || userId.isEmpty || pass.isEmpty) return false;
    dynamic newData = PasswordModel(
      websiteName: webName,
      websitePassword: pass,
      websiteUserId: userId,
    );

    prefs.setString("$webName", "$userId||$pass");
    passwords.insert(0, newData);
    loadData();
    notifyListeners();
    return true;
  }

  // update new password
  Future<bool> updateNewData(String webName, String userId, String pass) async {
    final SharedPreferences prefs = await _prefs;
    if (!prefs.containsKey(webName)) {
      return false;
    }
    prefs.remove(webName);
    prefs.setString("$webName", "$userId||$pass");
    dynamic newData = PasswordModel(
      websiteName: webName,
      websitePassword: pass,
      websiteUserId: userId,
    );
    passwords.insert(0, newData);
    notifyListeners();
    return true;
  }

  // delete data...
  Future<bool> deleteAData(String webName) async {
    final SharedPreferences prefs = await _prefs;
    if (!prefs.containsKey(webName)) {
      return false;
    }
    prefs.remove(webName);
    notifyListeners();
    return true;
  }
}
