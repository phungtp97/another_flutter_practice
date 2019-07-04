import 'package:flutter_clean_architecture/data/platform/platform_service.dart';
import 'package:flutter_clean_architecture/data/local/db/db_helper.dart';
import 'package:flutter_clean_architecture/data/local/pref/pref_api.dart';
import 'package:flutter_clean_architecture/data/network/api_service.dart';

abstract class BaseRepository {
  final PrefsHelper prefsHelper;
  final PlatformService platformService;
  final ApiService apiService;
  final DatabaseHelper databaseHelper;
  BaseRepository(this.apiService, this.prefsHelper, this.platformService, this.databaseHelper);

  void dispose() {

  }

  void functionThatWillBeUsedInDifferentPlace(){
    print("do things that repeat many times");
  }
}