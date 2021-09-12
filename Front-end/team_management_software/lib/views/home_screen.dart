import 'package:flutter/material.dart';
import 'package:team_management_software/views/chat_section/chatting_screen.dart';
import 'package:team_management_software/views/chat_section/coversation_list.dart';
import 'package:team_management_software/views/project_screen.dart';
import 'package:team_management_software/views/screens/account.dart';
import 'package:team_management_software/views/screens/dashboard.dart';
import 'package:team_management_software/views/screens/inbox.dart';
import 'package:team_management_software/views/screens/mytasks.dart';
import 'package:team_management_software/views/screens/search.dart';
import 'package:team_management_software/views/test_screen.dart';
import 'chat_section/push_notification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseNotification firebaseNotification = FirebaseNotification();
  @override
  void initState() {
    firebaseNotification.initialise(context);
    firebaseNotification.subscribeToTopic("puppy");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("HOME SCREEN"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConversationListPage()
                        // ChattingScreen("token", "Rohit")
                        ));
                print("open the chat section");
              },
              icon: Icon(Icons.chat))
        ],
      ),
      body: Center(
        child: TextButton(
          child: Text("Project section"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjectScreen()));
          },
        ),
      ),
    );
  }
}

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
