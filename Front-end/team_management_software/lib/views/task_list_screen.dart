import 'package:flutter/material.dart';
import 'package:team_management_software/views/components/new_task.dart';

import '../constants.dart';
import '../test_screen2.dart';

class TaskListScreen extends StatefulWidget {
 final String? name;
   const TaskListScreen({Key? key,required this.name}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
     return
    Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        automaticallyImplyLeading: false,
        leading:
        GestureDetector(
          onTap:(){
            Navigator.pop(context);
          },
          child: Container(
            //color: Colors.red,
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.arrow_back_ios,size: 25,color: Colors.yellow[800],)),
        ),
        title: Text(widget.name??"",style: TextStyle(color: Colors.yellow[800],fontWeight: FontWeight.w300,fontSize: 25),),
        backgroundColor: Colors.black,
       ),
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
      body:

      Column(
        children: [
          // Table(
          //   border: TableBorder.all(),
          //   columnWidths: const <int, TableColumnWidth>{
          //     0:  FixedColumnWidth(250),
          //     1:  FixedColumnWidth(400),
          //     2: FixedColumnWidth(400),
          //   },
          // //  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //   children: <TableRow>[
          //     TableRow(
          //       children: <Widget>[
          //         Expanded(
          //           child: Container(
          //             padding: EdgeInsets.all(10),
          //           //  height: 80,
          //             color: Colors.green,
          //             child: Text("okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkoooooooooooooooooooooooookkkkkkkkkk"),
          //           ),
          //         ),
          //         TableCell(
          //           verticalAlignment: TableCellVerticalAlignment.top,
          //           child: Container(
          //             height: 32,
          //             width: 320,
          //             color: Colors.red,
          //             child: Text("hellllllllllllllllllllllllllllllllllooooooooooooo"),
          //           ),
          //         ),
          //         Container(
          //           height: 64,
          //           color: Colors.blue,
          //         ),
          //       ],
          //     ),
          //     TableRow(
          //       decoration: const BoxDecoration(
          //         color: Colors.grey,
          //       ),
          //       children: <Widget>[
          //         Container(
          //           height: 64,
          //           width: 128,
          //           color: Colors.purple,
          //         ),
          //         Container(
          //           height: 32,
          //           color: Colors.yellow,
          //         ),
          //         Center(
          //           child: Container(
          //             height: 32,
          //             width: 32,
          //             color: Colors.orange,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),


          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(

                  height: 130,
                //  width: 200,
                  color: Colors.blueAccent,
                  child: Text("hellllllllooooooooooooooooookkkkkkkkkkk"),
                ),
              ),
              Expanded(
                flex:2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(300),
                      1:  FixedColumnWidth(400),
                      2: FixedColumnWidth(400),
                    },
                    //  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            color: Colors.grey,
                            padding: EdgeInsets.all(10),
                           child: Text("Tasks"),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              color: Colors.red,
                              height: 40,
                              child: Text("Assigneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"),


                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.blue,
                          ),

                        ],
                      ),
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        children: <Widget>[
                          Container(
                            height: 64,
                            width: 128,
                            color: Colors.purple,
                          ),
                          Container(
                            height: 32,
                            color: Colors.yellow,
                          ),
                          Center(
                            child: Container(
                              height: 32,
                              width: 32,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(

                  height: 130,
                  //  width: 200,
                  color: Colors.blueAccent,
                  child: Text("hellllllllooooooooooooooooookkkkkkkkkkk"),
                ),
              ),
              Expanded(
                flex:2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(300),
                      1:  FixedColumnWidth(400),
                      2: FixedColumnWidth(400),
                    },
                    //  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            color: Colors.grey,
                            padding: EdgeInsets.all(10),
                            child: Text("Tasks"),
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              color: Colors.red,
                              height: 40,
                              child: Text("Assigneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"),


                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.blue,
                          ),

                        ],
                      ),
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        children: <Widget>[
                          Container(
                            height: 64,
                            width: 128,
                            color: Colors.purple,
                          ),
                          Container(
                            height: 32,
                            color: Colors.yellow,
                          ),
                          Center(
                            child: Container(
                              height: 32,
                              width: 32,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
         );

  }
}

