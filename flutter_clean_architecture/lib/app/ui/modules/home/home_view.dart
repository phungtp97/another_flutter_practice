import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomeView> with TickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    _tabController = new TabController(length: 3, vsync: this);
    _pageController = new PageController(
        initialPage: 1, keepPage: true, viewportFraction: 1.0);
    _tabController.addListener(() {
      /*print("Tabcontroller ${_tabController.index}");

      if (_tabController.index == 2) {
        _tabController.animateTo(1);
      }*/
    });
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Test Flexible TabbarView"),
          ),
          body: homeView(_tabController),
          bottomNavigationBar: homeTabs(_tabController),
        ),
      ),
    );
  }

  Widget homeView(TabController controller) {
    return TabBarView(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
              controller: _pageController,
              children: <Widget>[
                Container(
                  color: Colors.pink,
                ),
                Container(
                  color: Colors.cyan,
                ),
                Container(
                  color: Colors.deepPurple,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: new PageIndicator(
                layout: PageIndicatorLayout.WARM,
                size: 8.0,
                controller: _pageController,
                space: 5.0,
                count: 3,
              ),
            )
          ],
        ),
        Text("History"),
        Text("Account"),
      ],
    );
  }

  Container homeTabs(TabController controller) {
    return Container(
      color: Colors.lightBlueAccent,
      height: 64,
      child: TabBar(
        controller: controller,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.white,
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
          Tab(text: "Account", icon: Icon(Icons.account_circle)),
        ],
      ),
    );
  }
}
