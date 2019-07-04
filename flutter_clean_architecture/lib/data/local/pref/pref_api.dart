import 'package:flutter_clean_architecture/data/entity/user.dart';

abstract class PrefsHelper{
  String getResultString();

  Future<User> getCurrentUser();
}