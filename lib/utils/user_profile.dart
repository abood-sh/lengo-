import 'package:flutter/cupertino.dart';
import 'package:lengo/model/user-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {

  static final UserProfile shared = UserProfile();

  Future<UserModel> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return userModelFromJson(prefs.get('user'));
    } catch(e) {
      return null;
    }
  }

  setUser({ @required UserModel user }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user == null ? null : userModelToJson(user));
    } catch(e) {

    }
  }

}