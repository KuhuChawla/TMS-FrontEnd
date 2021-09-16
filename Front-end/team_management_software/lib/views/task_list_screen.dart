// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:team_management_software/views/components/new_task.dart';
import 'package:provider/src/provider.dart';
import 'package:team_management_software/views/components/task_tile.dart';

import '../../change_notifier.dart';

class TaskListScreen extends StatefulWidget {
 final String projectId,projectName;
    TaskListScreen({Key? key,required this.projectId,required this.projectName}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  var taskList;
  bool isLoading=true;

  getTaskList(String projectName){
    taskList=  context.watch<Data>().taskListNotifier;
  }
  updateTaskList()async{
    await context.read<Data>().getTasksListFromServerForProject(widget.projectId);

    isLoading=false;
  }
  @override
  void initState() {
    // getDeviceToken();
    //updateConversationList();
    //print(widget.projectId +".............................................");
    updateTaskList();

    super.initState();
  }
  @override
  void didChangeDependencies() async{
    getTaskList("projectName");
    //await getTaskList("okay");
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return
                  CreateTask(projectId: widget.projectId,);
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
          widget.projectName,
          style: TextStyle(
              color: Colors.yellow[800],
              fontWeight: FontWeight.w300,
              fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: isLoading?CircularProgressIndicator():
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
                },
                child:   TaskListItem(index: index,
                  isChecked: taskList[index]["isCompleted"]??false, dueDate: taskList[index]["dueDate"]??" ", taskName: data["taskname"],
                  taskDescription: data["description"],taskId: taskList[index]["_id"]??" ",projectId: widget.projectId,
                )
              //  UserTile(thisIsList[index]["fullName"]!)

            );
        },
      ),
    );
  }
}

