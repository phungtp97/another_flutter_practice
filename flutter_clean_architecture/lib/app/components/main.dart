import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app/components/bloc_builder.dart';
import 'package:flutter_clean_architecture/app/bloc/main/main_bloc.dart';
import 'package:flutter_clean_architecture/app/ui/modules/home/home_view.dart';
import 'package:flutter_clean_architecture/app/ui/modules/main/main_view.dart';
import 'package:flutter_clean_architecture/data/local/db/app_db_helper.dart';
import 'package:flutter_clean_architecture/data/local/db/db_helper.dart';
import 'package:flutter_clean_architecture/data/local/pref/app_pref.dart';
import 'package:flutter_clean_architecture/data/local/pref/pref_api.dart';
import 'package:flutter_clean_architecture/data/network/api_service.dart';
import 'package:flutter_clean_architecture/data/network/app_api_service.dart';
import 'package:flutter_clean_architecture/data/platform/camera_platform_service.dart';
import 'package:flutter_clean_architecture/data/repository/user/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final GetIt locator = new GetIt();

GetIt get() => locator;

void main() {

  setUpLocator(locator);
  locator.registerSingleton<BlocBuilder>(BlocBuilder());

  return runApp(MultiProvider(providers: [
    Provider<BlocBuilder>.value(value: locator.get<BlocBuilder>()),
    Provider<GetIt>.value(value: locator)
  ], child: Application()));
}

void setUpLocator(GetIt locator) {
  //locator.registerSingleton<ScreenBuilder>(ScreenBuilder());

  locator.registerSingleton<ApiService>(AppApiService());

  locator.registerSingleton<String>("SampleApp");

  locator.registerSingleton<PrefsHelper>(AppPreferencesHelper());

  locator.registerSingleton<DatabaseHelper>(AppDatabaseHelper(locator.get<String>()));

  locator.registerSingleton<CameraPlatformService>(CameraPlatformService("lecle.com/invoker"));

  locator.registerSingleton<UserRepository>(UserRepository(locator.get<ApiService>(),
      locator.get<PrefsHelper>(),
      locator.get<CameraPlatformService>(),
      locator.get<DatabaseHelper>()));

  print("check is null ${locator.get<UserRepository>() == null}");
}

// ignore: must_be_immutable
class Application extends StatelessWidget{
  GetIt locator;
  @override
  Widget build(BuildContext context) {
    locator = Provider.of(context);
    return MaterialApp(home: MainView(locator.get<UserStateBloc>()), title: "Test Clean Architecture",);
  }
}
