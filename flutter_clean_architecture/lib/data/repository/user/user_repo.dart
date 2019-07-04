import 'package:flutter_clean_architecture/base/base_repo.dart';
import 'package:flutter_clean_architecture/data/entity/user.dart';
import 'package:flutter_clean_architecture/data/platform/platform_service.dart';
import 'package:flutter_clean_architecture/data/local/db/db_helper.dart';
import 'package:flutter_clean_architecture/data/local/pref/pref_api.dart';
import 'package:flutter_clean_architecture/data/network/api_service.dart';
import 'package:rxdart/rxdart.dart';

class UserRepository extends BaseRepository {
  final ApiService apiService;
  final PrefsHelper prefsHelper;
  final PlatformService platformService;
  final DatabaseHelper databaseHelper;
  UserRepository(this.apiService, this.prefsHelper, this.platformService, this.databaseHelper)
      : super(apiService, prefsHelper, platformService, databaseHelper);

  Future<User> getUser() {
    return prefsHelper.getCurrentUser();
  }

  @override
  void functionThatWillBeUsedInDifferentPlace() {

  }


}
