import 'package:covid_app/screens/departement_screen.dart';
import 'package:covid_app/screens/info_screen.dart';
import 'package:covid_app/screens/screens.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    HomeScreen(),
    StatsScreen(),
    // DepartementScreen(),
    InfoScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 0.0,
          onTap: (index) => setState(() => _currentIndex = index),
          items:
              [Icons.home, Icons.insert_chart, /*Icons.event_note,*/ Icons.info]
                  .asMap()
                  .map((key, value) => MapEntry(
                        key,
                        BottomNavigationBarItem(
                            label: '',
                            icon: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 16.0,
                              ),
                              decoration: BoxDecoration(
                                color: _currentIndex == key
                                    ? Colors.blue[600]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Icon(value),
                            )),
                      ))
                  .values
                  .toList()),
    );
  }
}
