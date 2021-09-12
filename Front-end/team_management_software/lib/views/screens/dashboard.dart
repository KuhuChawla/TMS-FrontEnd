import 'package:flutter/material.dart';
import 'package:team_management_software/views/home_screen.dart';
import 'package:team_management_software/views/screens/account.dart';
import 'package:team_management_software/views/screens/inbox.dart';
import 'package:team_management_software/views/screens/mytasks.dart';
import 'package:team_management_software/views/screens/search.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final screen = [HomeScreen(), MyTasks(), Inbox(), Search(), Account()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.splitscreen),
              label: 'MyTasks',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_alert),
              label: 'Inbox',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
              backgroundColor: Colors.black),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: screen[_selectedIndex],
    );
  }
}
