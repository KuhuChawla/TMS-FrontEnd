import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:team_management_software/constants.dart';

import '../../change_notifier.dart';

class CreateTask extends StatefulWidget {
  String projectId;
   CreateTask({Key? key,required this.projectId}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {


  final taskNameController=TextEditingController();
  final taskDescriptionController=TextEditingController();

  showSnackBArForProjectError(errorMessage) {
    final snackBar = SnackBar(
      content:  Text(errorMessage),
      duration: const Duration(milliseconds: 1000),
      // width: 200,
      margin: EdgeInsets.only(
          left: 40, right: MediaQuery.of(context).size.width - 250, bottom: 5),
      //  backgroundColor: Colors.yellow[800],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  createNewTask()async{
    if(taskNameController.text!="" ) {
      if(isPicked){
        await context.read<Data>().addTaskInNotifier(taskName: taskNameController.text,
          taskDescription: taskDescriptionController.text,
          dueDate: selectedDate.toString(),
          projectId: widget.projectId

        );
        Navigator.pop(context);
      }
      else {
        showSnackBArForProjectError("Select Date To Continue");
      }

    }
    else{
      showSnackBArForProjectError("Enter Required Fields");
    }
  }



  DateTime selectedDate=  DateTime.now();
  bool isPicked=false;
  String date=" ";

  selectDate(BuildContext context) async {
    final DateTime ?picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        isPicked=true;
        selectedDate = picked;
        date = picked.day.toString() +
            "-" +
            picked.month.toString() +
            "-" +
            picked.year.toString();

      });
    }
  }

  assignTask(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.18,
      color: Colors.red,
      alignment: Alignment.bottomCenter,
      child: Scaffold(
        body: Container(
          color: const Color(
              0xFF737373), // this color is similar to the color of non focused area
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0))),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 0, left: 50, right: 50),
                    child: Column(
                      children: [
                        const Text(
                          "_____",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 12, bottom: 20),
                          child: Column(
                            children: [
                              Text(
                                "Add New Task",
                                style: TextStyle(
                                    wordSpacing: 3,
                                    fontSize: 23,
                                    color: Colors.yellow[800],
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        //SizedBox(height: 20),
                        TextFormField(
                          autofocus: true,
                           controller: taskNameController,
                          onChanged: (val) {
                            // input=val;
                          },
                          decoration:
                          Constants.kTextFormFieldDecorationForFProject(
                              "TASK NAME *"),
                        ),
                        TextFormField(
                          controller: taskDescriptionController,
                          decoration:
                          Constants.kTextFormFieldDecorationForFProject(
                              "DESCRIPTION "),
                        ),

                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Row(children: [
                            true
                                ? Container(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Unassigned",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ))
                                : Container(),
                            const SizedBox(
                              width: 30,
                            ),
                            true
                                ? GestureDetector(
                              onTap: (){
                                selectDate(context);
                              },
                              child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child:  Icon(
                                          Icons.date_range,
                                          color: isPicked?Colors.black:Colors.grey,
                                        ),
                                        backgroundColor: isPicked?Colors.yellow[800]: Colors.grey[200],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text( !isPicked?
                                      "Due Date":date,
                                        style: isPicked?const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                        ):const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )),
                            )
                                : Container(),

                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 5,
                        right: 20,
                      ),
                      child: RawMaterialButton(
                        onPressed: () {
                          createNewTask();

                        },
                        fillColor: Colors.yellow[800],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
