import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architecture/data/entity/user.dart';
import 'package:flutter_clean_architecture/data/repository/user/user_repo.dart';

/*
enum MainEvent { loading, decideView, init, signUp }
*/

abstract class MainBloc extends Bloc<MainEvent, UserState> {
  final UserRepository repo;

  MainBloc(this.repo);

  void getUser();

  void signIn(String email, String password);
}

class UserStateBloc extends MainBloc {
  final UserRepository repo;

  UserStateBloc(this.repo) : super(repo);

  @override
  void getUser() async {
    dispatch(MainEvent._init());
  }

  @override
  UserState get initialState => UserState._userLoading(0);

  @override
  Stream<UserState> mapEventToState(MainEvent event) async* {
    if (event is MainInitEvent) {
      for (int i = 0; i <= 10; i++) {
         yield await Future<UserLoadingState>.delayed(const Duration(milliseconds: 100), () async {
           return UserState._userLoading(i);
        });
            if(i <= 10)
        {
          dispatch(MainEvent._decideView());
        }
      }
    }
    if (event is MainDecideViewEvent) {
      User user = await repo.getUser();
      if (user == null) {
        yield UserState._userData(user);
      }
      else {
        yield UserState._userData(user);
      }
    }
    if (event is MainSignUpEvent){
      yield UserState._userSignInSuccess(event.user);
    }
  }

  @override
  void signIn(String email, String password) {
    User user = new User(email: email, password: password);
    dispatch(MainEvent._signInEvent(user));
  }
}

class MainEvent {
  MainEvent();

  factory MainEvent._init() = MainInitEvent;
  factory MainEvent._decideView() = MainDecideViewEvent;
  factory MainEvent._signInEvent(User user) = MainSignUpEvent;
}

class MainInitEvent extends MainEvent{
}

class MainDecideViewEvent extends MainEvent{

}

class MainSignUpEvent extends MainEvent{
  final User user;

  MainSignUpEvent(this.user);

}


class UserState {
  UserState();

  factory UserState._userEmpty() = UserInitState;

  factory UserState._userLoading(int progress) = UserLoadingState;

  factory UserState._userData(User user) = UserDataState;

  factory UserState._userError(Exception t) = UserErrorState;

  factory UserState._userSignInSuccess(User user) = UserSignInSuccessState;
}

class UserDataState extends UserState {
  UserDataState(this.user);

  final User user;
}

class UserLoadingState extends UserState {
  int progress = 0;

  UserLoadingState(this.progress);

}

class UserInitState extends UserState {
}

class UserErrorState extends UserState {
  UserErrorState(this.e);

  final Exception e;
}

class UserSignInSuccessState extends UserState {
  final User user;

  UserSignInSuccessState(this.user);

}