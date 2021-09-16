import 'package:flutter/material.dart';
import 'package:team_management_software/controller/helper_function.dart';
// import 'shared_pref_functions.dart';
// import 'function_handler.dart';

class Data with ChangeNotifier {
  HelperFunction helperFunction = HelperFunction();
  List listOfMessagesNotifier = [];
  List listOfTokensNotifier = [];
  List listOfProjectsNotifier = [
    // {"name": "rohit","description":"good boy"},
  ];
  List taskListNotifier = [
    // {
    //   "taskName": "taskName",
    //   "isDone": false,
    //   "taskDescription": "desc",
    //   "priority": 1,
    //   "status": "stuck",
    //   "dueDate":"2021-09-08 00:00:00.000"
    // },
    // {
    //   "taskName": "taskName2",
    //   "isDone": false,
    //   "taskDescription": "desc",
    //   "priority": 1,
    //   "status": "stuck",
    //   "dueDate":"2021-09-08 00:00:00.000"
    // }
  ];

  getTasksListFromServerForProject(projectId)async{

    taskListNotifier=await helperFunction.getAllTasksWithProjectId(projectId);
    notifyListeners();

  }
  updateTaskList(index,projectId,taskId,dataToSend) {
    print("updating $index");
    taskListNotifier[index]["isCompleted"] = !taskListNotifier[index]["isCompleted"];
    notifyListeners();
    //send a patch req   /projects/id/tasks/taskId
    helperFunction.updateTask(projectId, taskId, dataToSend);
  }

  addTaskToProject(projectId,taskData)async{
    print("adding task to projectId $projectId");
    //send post req to project id
   await helperFunction.addTaskToProject(projectId, taskData);
    notifyListeners();
   await getTasksListFromServerForProject(projectId);

  }

  addTaskInNotifier({
    required taskName,
    required taskDescription,
    required dueDate,
    required projectId
  }) {
    var newTask={
      "taskname":taskName,
      "description":taskDescription??"not added",
      "isCompleted":false,
      "dueDate":dueDate,
      "priority":"1",
      "assigned":false,
      "username":"user3"
    };
    print("adding task");

    taskListNotifier.add(newTask);
    notifyListeners();
    addTaskToProject(projectId, newTask);

  }

  String key = "";
  bool loadingScreen = false;
  bool isLoadingContent = false;
  toggleLoading() {
    loadingScreen = !loadingScreen;
    notifyListeners();
  }

  updateKey(String newKey) {
    key = newKey;
  }

  addProjectToList(projectDetails) {
    listOfProjectsNotifier.add(projectDetails);
    notifyListeners();
    helperFunction.addProjectToDatabase(projectDetails);
  }


  removeProjectFromList(index) {
    listOfProjectsNotifier.removeAt(index);
    notifyListeners();
  }

  updateProjectListFromServer() async {
    listOfProjectsNotifier = await helperFunction.getAllProjectDetails();
    notifyListeners();
  }

  updateTokenListFromSharedPref() async {
    // listOfTokensNotifier =
    // await SecureStorageFunction.getTokensDataFromSharedPrefs();
    // notifyListeners();
  }

  updateMessageListFromSharedPref(String key) async {
    // listOfMessagesNotifier =
    // await SecureStorageFunction.getDataFromSharedPref(key);
    // notifyListeners();
  }
  updateMessageListFromServer(userName)async{
    print("updating message from notifier");
    listOfMessagesNotifier= await helperFunction.getAllMessagesByUserName(userName);
    notifyListeners();
  }

  addToUniqueList(text, key) {
    //print("func called");
    listOfMessagesNotifier.add(text);
    notifyListeners();
    // SecureStorageFunction.saveDataToSharedPref(listOfMessagesNotifier, key);
  }

  addToUniqueListFromServer(
      text, String type, String sendBy, String fileName) async {
    // listOfMessagesNotifier=[{"msg":"first text"}];
    var newMessage = {
      "message": text,
      "sendBy": sendBy,
      "type": type,
      "fileName": fileName,
     // "timeStamp": timeStamp.toString()
    };
    //print(newMessage);
    if (key == sendBy) {
      listOfMessagesNotifier.add(newMessage);
      notifyListeners();
      //   await SecureStorageFunction.saveDataToSharedPref(
      //       listOfMessagesNotifier, from);
      // } else {
      //   var tempList = await SecureStorageFunction.getDataFromSharedPref(from);
      //   tempList.add(newMessage);
      //   await SecureStorageFunction.saveDataToSharedPref(tempList, from);
      // }
    }
  }

  removingMessage(int index, String key) {
    //print("removing a message function");
    listOfMessagesNotifier.removeAt(index);
    notifyListeners();
    // SecureStorageFunction.saveDataToSharedPref(listOfMessagesNotifier, key);
    //send a notification to remove
  }

  removingMessageFromServer(String timeStamp, String from) async {
    //print("removing message from server");
    if (key == from) {
      listOfMessagesNotifier
          .removeWhere((element) => element["timeStamp"] == timeStamp);
      notifyListeners();
      //   await SecureStorageFunction.saveDataToSharedPref(
      //       listOfMessagesNotifier, from);
      // } else {
      //   var tempList = await SecureStorageFunction.getDataFromSharedPref(from);
      //   tempList.removeWhere((element)=>element["timeStamp"]==timeStamp);
      //   await SecureStorageFunction.saveDataToSharedPref(tempList, from);
      // }
    }
  }

  //List get getlist => listOfMessagesNotifier;


  getTokensDataFromHttp() async {
    listOfTokensNotifier = await helperFunction.getAllTokens();
    notifyListeners();
    // await SecureStorageFunction.saveTokensDataToSharedPrefs(
    //     listOfTokensNotifier);
  }

  getAllMessagesByUserName(String userName)async{
    listOfMessagesNotifier=await helperFunction.getAllMessagesByUserName(userName);
    notifyListeners();
  }


}
