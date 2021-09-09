import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:team_management_software/controller/helper_function.dart';
import 'package:team_management_software/views/components/new_project_floating_button.dart';
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
    projects =  context.watch<Data>().listOfProjects;
  }

  removingFromList(index) {}
  updatingTheList() {
    context.read<Data>().updateProjectListFromServer();
  }

  @override
  void didChangeDependencies() async {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Project Section",
          style: TextStyle(color: Colors.yellow),
        ),
      ),
      floatingActionButton: floatingButtonForNewProject(context),
      body: projects.isEmpty ? Center(child: CircularProgressIndicator(
        color: Colors.yellow,
        backgroundColor: Colors.black,
      )
      ): ReorderableListView.builder(
        onReorder: reorderData,
        itemCount: projects.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
              onDismissed: (direction) {
                // setState(() {
                //   projects.removeAt(index);
                // });
                context.read<Data>().removeProjectFromList(index);

                //showing a snackBar after removing a project
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dismissed project')));
              },
              key: Key(projects[index]["name"]),
              child: Container(
                height: 150,
                alignment: Alignment.center,
                child: Card(
                    color: Colors.orange[50],
                    shadowColor: Colors.grey,
                    elevation: 2,
                    //margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      // contentPadding: EdgeInsets.only(left: 20,right:10,top:12,bottom: 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            //  mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(projects[index]["name"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                projects[index]["description"],
                                textAlign: TextAlign.left,
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )),
              ));
        },
      ),
    );
  }
}
