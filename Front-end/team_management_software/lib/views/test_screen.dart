import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../change_notifier.dart';
class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  var projects;
  Future gettingTheList() async
  {
    projects=   context.watch<Data>().listOfProjects;
  }

  @override
  void initState() {
    context.read<Data>().updateProjectListFromServer();
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    await gettingTheList();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("test page"),),
      body: FutureBuilder(
          future: gettingTheList(),
          builder: (ctx, snapshot) {
           // var value = (snapshot.connectionState == ConnectionState.done) ? '${_category.catToDo}' : '0';
            if(snapshot.connectionState==ConnectionState.done){
              print("fetching done");
              return Text(
                "done",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              );
            }else{
              print("fetching is going on");
              return CircularProgressIndicator();

            }


          }
      ),
    );
  }
}
