import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app/bloc/main/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/app/ui/modules/home/home_view.dart';
import 'package:flutter_clean_architecture/data/entity/user.dart';
import 'package:flutter_clean_architecture/res/color.dart';
import 'package:flutter_clean_architecture/res/style.dart';

class MainView extends StatefulWidget {
  MainView(this.bloc, {Key key, this.title}) : super(key: key);

  final String title;
  final UserStateBloc bloc;

  @override
  _MainState createState() => _MainState(bloc);
}

class _MainState extends State<MainView> with TickerProviderStateMixin{
  final UserStateBloc bloc;
  ResourceStyles resourceStyles = new ResourceStyles();

  _MainState(this.bloc);

  @override
  Widget build(BuildContext context) {
     _tabController =  new TabController(length: 3, vsync: this);
    bloc.getUser();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasks',
        home: BlocBuilder(
            bloc: bloc,
            builder: (context, snapShot) {
              return DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: PreferredSize(
                    child: LayoutBuilder(builder: (context, cons) {
                      return AppBar(
                        title: Text("AuthView"),
                        backgroundColor: Colors.blue,
                      );
                    }),
                    preferredSize: Size(
                        double.infinity, snapShot is UserLoadingState ? 0 : 50),
                  ),
                  bottomNavigationBar: snapShot is UserSignInSuccessState
                      ? homeTabs()
                      : Container(
                          height: 0,
                        ),
                  body: LayoutBuilder(builder: (context, constraints) {
                    print("just check in ${snapShot is UserLoadingState}}");
                    print("${snapShot.toString()}");
                    if (snapShot is UserLoadingState) {
                      print("${snapShot.progress}");
                      return splashScreen(snapShot);
                    }
                    if (snapShot is UserDataState) {
                      return mainView(snapShot);
                    }
                    if (snapShot is UserSignInSuccessState) {
                      return Container();
                    }
                  }),
                  floatingActionButton: new FloatingActionButton(
                    onPressed: () {
                      _modalBottomSheetMenu(context);
                    },
                    child: new Icon(Icons.add),
                  ),
                ),
              );
            }));
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            color: Colors.black26,
            child: new Container(
                height: 200,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Colors.indigo[800],
                        Colors.indigo[700],
                        Colors.indigo[600],
                        Colors.indigo[400],
                      ],
                    ),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(30.0),
                        topRight: const Radius.circular(30.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                )),
          );
        });
  }

  Widget mainView(UserDataState user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: signUpList(),
    );
  }
  TabController _tabController;
  Widget homeView(User user) {
    _tabController.addListener(() {
      print("Tabcontroller ${_tabController.index}");
    }
    );

    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Text("Home"),
        Text("History"),
        Text("History"),
      ],
    );
  }

  Container homeTabs() {
    return Container(
      color: Colors.grey,
      height: 64,
      child: TabBar(
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black38,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "Home",
            icon: Icon(Icons.home),
          ),
          Tab(
            text: "History",
            icon: Icon(Icons.history),
          ),
          Tab(
            text: "Account",
            icon: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.email),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.red,
                  ),
                  child: Text(
                    "9",
                    style: TextStyle(fontSize: 9.0, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> signUpList() {
    String textEmail;

    String textPassword;

    return <Widget>[
      resourceStyles.textFieldBuilder(Icons.email, "Type your email",
          dot: false, callbackText: (text) => textEmail),
      SizedBox(
        height: 8,
      ),
      resourceStyles.textFieldBuilder(Icons.lock, "Type your password",
          dot: true, callbackText: (text) => textPassword),
      SizedBox(
        height: 16,
      ),
      RaisedButton(
        onPressed: () {
          bloc.signIn(textEmail, textPassword);
        },
        child: Text(
          "SignIn",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blueAccent,
      )
    ];
  }

  Widget splashScreen(UserLoadingState snapShot) {
    double maxSize = 220;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Container(
        height: 40,
        alignment: Alignment.centerLeft,
        width: 220,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              color: Colors.blue,
              width: snapShot.progress / 10 * maxSize,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black38,
                      width: 2,
                      style: BorderStyle.solid)),
              width: maxSize,
            ),
          ],
        ),
      ),
    );
  }
}
