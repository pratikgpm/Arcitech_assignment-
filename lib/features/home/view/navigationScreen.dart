import 'package:arcitech/core/theme/app_pallete.dart';
import 'package:arcitech/features/home/view/FavoriteScreen.dart';
import 'package:arcitech/features/home/view/HomeScreen.dart';
import 'package:arcitech/features/home/view/ProductScreen.dart';
import 'package:arcitech/features/home/view/ProfileScreen.dart';
import 'package:arcitech/features/home/view/SearchScreen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => MyHomePage(),
      );

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProductScreen(),
    SearchScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Pallete.bgBlue,
        unselectedIconTheme: IconThemeData(color: Pallete.formFieldGrey),
        onTap: _onItemTapped,
      ),
    );
  }
}
