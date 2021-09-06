import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:team_management_software/controller/helper_function.dart';
import '../change_notifier.dart';
import '../constants.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  List projects = [];
  String input = "";
  HelperFunction helperFunction=HelperFunction();

  gettingTheList() async
  {
    projects = context.watch<Data>().listOfProjects;
  }
  removingFromList(index)
  {


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    gettingTheList();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();

    projects.add("Project1");
  }

  onProjectItemMenuTap(){

  }
  void reorderData(int oldindex, int newindex){

    setState(() {
      if(newindex>oldindex){
        newindex-=1;
      }
      final items =projects.removeAt(oldindex);
      projects.insert(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Project Section",style: TextStyle(color: Colors.yellow),),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text("ADD A NEW PROJECT",style: TextStyle(
                        fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'
                      ),),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                           // controller: nameController,
                            onChanged: (val){
                              input=val;
                            },
                            validator: (val) {
                              val ??= " ";

                             // val.length >= 4 ? null : errorInForm(0);
                              return val.length >= 4
                                  ? null
                                  : " Enter a valid name";
                            },
                            decoration:
                            Constants.kTextFormFieldDecoration("NAME"),
                          ),
                          TextFormField(
                            // controller: nameController,
                            validator: (val) {
                              val ??= " ";

                              // val.length >= 4 ? null : errorInForm(0);
                              return val.length >= 4
                                  ? null
                                  : " Enter a valid name";
                            },
                            decoration:
                            Constants.kTextFormFieldDecoration("DESCRIPTION"),
                          ),
                          TextFormField(
                            // controller: nameController,
                            validator: (val) {
                              val ??= " ";

                              // val.length >= 4 ? null : errorInForm(0);
                              return val.length >= 4
                                  ? null
                                  : " Enter a valid name";
                            },
                            decoration:
                            Constants.kTextFormFieldDecoration("GITHUB LINK"),
                          ),
                          TextFormField(
                            // controller: nameController,

                            validator: (val) {
                              val ??= " ";

                              // val.length >= 4 ? null : errorInForm(0);
                              return val.length >= 4
                                  ? null
                                  : " Enter a valid name";
                            },
                            decoration:
                            Constants.kTextFormFieldDecoration("DOCUMENT LINK"),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () async{
                              if(input.isNotEmpty) {
                                context.read<Data>().addProjectToList(input);
                              }
                          // await  helperFunction.addProjectToDatabase();
                              Navigator.of(context).pop();
                            },
                            child: const Text("ADD",style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange
                            ),))
                      ]);
                },
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.yellow[600],
            )),
        body: ReorderableListView.builder(
             onReorder: reorderData,
            itemCount: projects.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  onDismissed: (direction) {
                    // setState(() {
                    //   projects.removeAt(index);
                    // });
                    context.read<Data>().removeProjectFromList(index);


                      //showing a snackBar after removing a project
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Dismissed project')));
                  },
                  key: Key(projects[index]),
                  child: Container(
                    height: 100,
                    child: Card(
                      color: Colors.orange[50],
                     shadowColor: Colors.grey,
                        elevation: 2,
                        margin: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 20,right:10,top:12,bottom: 10),
                          title: Text(projects[index],
                              style: TextStyle(fontSize: 20)),
                          trailing: IconButton(icon:Icon(Icons.menu),onPressed: (){

                          },),
                        )),
                  ));
            })
    );
  }
}