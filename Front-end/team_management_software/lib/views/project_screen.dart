// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:team_management_software/controller/helper_function.dart';
import 'package:team_management_software/views/components/new_project.dart';
import 'package:team_management_software/views/screens/my_tasks.dart';
import 'package:team_management_software/views/task_list_screen.dart';
import 'package:team_management_software/views/test_screen.dart';
import '../change_notifier.dart';
import '../constants.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool isLoaded = false;
  var projects;
  String input = "";
  HelperFunction helperFunction = HelperFunction();

  gettingTheList() async {
    projects =  context.watch<Data>().listOfProjectsNotifier;
  }
  getConversationList() async {
   var  thisIsList = context.watch<Data>().listOfTokensNotifier;
  }

  removingFromList(index) {}
  updatingTheList() {
    context.read<Data>().updateProjectListFromServer();
  }

  @override
  void didChangeDependencies() async {
    //await getConversationList()
    await gettingTheList();
    isLoaded = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    updatingTheList();
  }

  onProjectItemMenuTap() {}
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = projects.removeAt(oldindex);
      projects.insert(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
         // toolbarHeight: 35,
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
          title: Text("Projects",style: TextStyle(color: Colors.yellow[800],fontWeight: FontWeight.w300,fontSize: 25),),
          backgroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
              alignment: Alignment.topLeft,
              child: TabBar(
                indicatorWeight: 3,
                indicatorColor: Colors.yellow[800],
                isScrollable: true,
                tabs: [
                  Container(
                    //width: 50,
                      child: Tab(text: 'All',height: 40,)),
                  Tab(text: 'Favourites',height: 40),
                  Tab(text: 'Recents',height: 40),
                ],
              ),
            ),
          ),

        ),
        floatingActionButton: const CreateNewProject(),
        //floatingButtonForNewProject(context),

        body:

        TabBarView(
          children: [
            projects.isEmpty ?  Center(child: CircularProgressIndicator(
              color: Colors.yellow[800],
              backgroundColor: Colors.black,
            )
            ):ListView.builder(
              shrinkWrap: true,
              //onReorder: reorderData,
              itemCount: projects.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return CardForProject(name:projects[index]["name"]??"name",
                  description:projects[index]["description"]??"description",
                  projectId: projects[index]["_id"],

                );
              },
            ),
            Container(),
            Container()
          ],
        ),
      ),
    );
  }
}

class CardForProject extends StatelessWidget {
  final name;
  final description;
  final projectId;
  const CardForProject({Key? key, this.name, this.description, this.projectId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Card(
        //color: Colors.orange[50],
          shadowColor: Colors.grey[500],

          //elevation: 2,
          //margin: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            // contentPadding: EdgeInsets.only(left: 20,right:10,top:12,bottom: 10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return TaskListScreen(projectId: projectId,projectName: name,);
                         //TaskListScreen(name: name,);
                     }));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(description
                            ,
                            textAlign: TextAlign.left,
                            style:  TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w300),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ),

              ],
            ),
          )),
    );
  }
}


