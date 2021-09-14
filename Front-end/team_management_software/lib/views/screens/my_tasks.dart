import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/src/provider.dart';
import 'package:team_management_software/views/components/new_task.dart';
import 'package:team_management_software/views/components/task_tile.dart';

import '../../change_notifier.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  _MyTasksState createState() => _MyTasksState();
}


class _MyTasksState extends State<MyTasks> {
  var taskList;

  getTaskList(String projectName){
  taskList=  context.watch<Data>().taskListNotifier;
  }
@override
  void initState() {
   // getDeviceToken();
    //updateConversationList();
    super.initState();
  }
  @override
  void didChangeDependencies() async{
    await getTaskList("okay");

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return
                  CreateTask();
              },
            );
          },
          child: Icon(
            Icons.add_task,
            color: Colors.yellow[800],
            size: 35,
          )),
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,
        title: Text(
          "My Tasks",
          style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w300,
              fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body:
      ListView.builder(
        shrinkWrap: true,
        itemCount:
        //30,
        taskList.length,
        itemBuilder: (context, index) {

          var data=taskList[index];
          return
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ChattingScreen(
                //           thisIsList[index]["token"],
                //           thisIsList[index]["fullName"])),
                // );
              },
                child:   TaskListItem(index: index,
                  isChecked: taskList[index]["isDone"], dueDate: taskList[index]["dueDate"]??" ", taskName: data["taskName"],
                  taskDescription: data["taskDescription"],
                )
              //  UserTile(thisIsList[index]["fullName"]!)

            );
        },
      ),
      // Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     TaskListItem(),
      //     TaskListItem()
      //   ],
      // ),
    );
  }
}



