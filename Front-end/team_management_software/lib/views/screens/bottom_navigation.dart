import 'package:flutter/material.dart';
import 'package:team_management_software/views/chat_section/coversation_list.dart';
import 'package:team_management_software/views/home_screen.dart';
import 'package:team_management_software/views/screens/account.dart';
import 'package:team_management_software/views/screens/inbox.dart';
import 'package:team_management_software/views/screens/my_tasks.dart';
import 'package:team_management_software/views/screens/search.dart';
import 'package:team_management_software/views/project_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final screen = [ProjectScreen(), MyTasks(projectId: "613462dcd02e903c1cbdf701",),  ConversationListPage(), SearchList(), Account()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white54,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex==0?Icons.home:Icons.home_outlined),
              label: 'Home',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex==1?Icons.splitscreen_sharp:Icons.splitscreen),
              label: 'MyTasks',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex==2?Icons.notifications:Icons.notifications_none_outlined),
              label: 'Inbox',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex==3?Icons.search_rounded:Icons.search),
              label: 'Search',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex==4?Icons.person:Icons.person_outline),
              label: 'Account',
              backgroundColor: Colors.black),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[800],
        onTap: _onItemTapped,
      ),
      body: screen[_selectedIndex],
    );
  }
}