import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:recipe_app/src/presentation/tabs/favorite_tab.dart';
import 'package:recipe_app/src/presentation/tabs/home_tab.dart';
import 'package:recipe_app/src/presentation/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  int _currentTabIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        children: [
          HomeTab(
            avatarOnPressed: () {
              setState(() {
                pageController.animateToPage(2,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
                _currentTabIndex = 2;
              });
            },
          ),
          FavoriteTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        currentIndex: _currentTabIndex,
        selectedItemColor: Theme.of(context).accentColor,
        selectedIconTheme: IconThemeData(size: 40),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(OMIcons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
        onTap: (index) {
          setState(() {
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 200), curve: Curves.linear);
            _currentTabIndex = index;
          });
        },
      ),
    );
  }
}
