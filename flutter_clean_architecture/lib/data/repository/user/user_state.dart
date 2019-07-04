import 'package:flutter_clean_architecture/data/entity/user.dart';

class UserState{
  UserState();
  factory UserState._userInit() = UserInitState;
  factory UserState._userLoading() = UserLoadingState;
  factory UserState._userData(User user) = UserDataState;
  factory UserState._userError(Exception t) = UserErrorState;
}

class UserDataState extends UserState{
  UserDataState(this.user);
  final User user;
}

class UserLoadingState extends UserState{

}

class UserInitState extends UserState {

}

class UserErrorState extends UserState {
  UserErrorState(this.e);
  final Exception e;
}
