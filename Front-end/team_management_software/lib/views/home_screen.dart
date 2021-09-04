import 'package:flutter/material.dart';
import 'package:team_management_software/views/project_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME SCREEN"),
      ),
      body: Center(
        child: FlatButton(
          child: Text(
            'SignUp',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Project()));
          },
        ),
      ),
    );
  }
}
