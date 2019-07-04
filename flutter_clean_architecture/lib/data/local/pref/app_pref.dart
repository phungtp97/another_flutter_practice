import 'dart:io';

import 'package:flutter_clean_architecture/data/entity/user.dart';
import 'package:flutter_clean_architecture/data/local/pref/pref_api.dart';


class AppPreferencesHelper implements PrefsHelper{

  AppPreferencesHelper();

  @override
  String getResultString() {
    return "Hello, I'm from AppPreferencesHelper";
  }

  @override
  Future<User> getCurrentUser() async{
    return User();
  }

}