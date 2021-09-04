import 'package:flutter/material.dart';

class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  List projects = [];
  String input = "";

  @override
  void initState() {
    super.initState();
    projects.add("Project1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text("Add New Project"),
                      content: TextField(
                        onChanged: (String value) {
                          input = value;
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              setState(() {
                                projects.add(input);
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text("ADD"))
                      ]);
                },
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.yellow[600],
            )),
        body: ListView.builder(
            itemCount: projects.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: Key(projects[index]),
                  child: Container(
                    height: 100,
                    child: Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text(projects[index],
                              style: TextStyle(fontSize: 20)),
                        )),
                  ));
            }) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
