import 'package:flutter/material.dart';
import 'package:ordering/screens/cart_screen.dart';
import 'package:ordering/screens/home_screen.dart';
import 'package:ordering/screens/profile_screen.dart';
import '../styles.dart';

class NavigationScreen extends StatefulWidget {
  static String id = 'NavigationScreen';

  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> _widgetOptions = [
    HomeScreen(
      key: PageStorageKey('Home'),
    ),
    CartScreen(key: PageStorageKey('Cart')),
    Profile(key: PageStorageKey('Profile'))
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xff202040),
        // fixedColor: Color(0xff707070),
        selectedItemColor: ThemeText.primaryColor,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home_outlined,
              )),
          BottomNavigationBarItem(
              label: 'Cart', icon: Icon(Icons.shopping_cart_outlined)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person_outlined)),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Home'),
        // ),
        backgroundColor: Color(0xff707070),
        body: PageStorage(
          child: _widgetOptions[_selectedIndex],
          bucket: bucket,
        ),
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex));
  }
}
