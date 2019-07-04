import 'package:flutter_clean_architecture/app/bloc/main/main_bloc.dart';
import 'package:flutter_clean_architecture/data/repository/user/user_repo.dart';
import 'main.dart' as main;

class BlocBuilder{

  BlocBuilder(){
    final locator = main.get();

    locator.registerFactory(() {
      return UserStateBloc(locator.get<UserRepository>());
    });
    //locator.registerSingleton<MainBloc>(MainBloc(locator.get<UserRepository>()));
  }

}