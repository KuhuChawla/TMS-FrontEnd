import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,
        title: Text("Profile",style: TextStyle(color: Colors.yellow[800],fontWeight: FontWeight.w300,fontSize: 25),),
        backgroundColor: Colors.black,
      ),
    );
  }
}
