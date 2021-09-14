import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,


        title: Text("Search",style: TextStyle(color: Colors.yellow[800],fontWeight: FontWeight.w300,fontSize: 25),),
        backgroundColor: Colors.black
        ,

      ),
    );
  }
}
