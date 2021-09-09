import 'package:flutter/material.dart';
import 'package:team_management_software/controller/helper_function.dart';
// import 'shared_pref_functions.dart';
// import 'function_handler.dart';

class Data with ChangeNotifier {
  HelperFunction helperFunction = HelperFunction();
  List listOfMessagesNotifier = [];
  List listOfTokensNotifier = [];
 List listOfProjects=[];
  String key = "";
  bool loadingScreen=false;
  bool isLoadingContent=false;
  toggleLoading(){
    loadingScreen=!loadingScreen;
    notifyListeners();
  }

  updateKey(String newKey) {
    key = newKey;
  }

  addProjectToList(projectDetails){
    listOfProjects.add(projectDetails);
    notifyListeners();
    helperFunction.addProjectToDatabase();
  }
  removeProjectFromList(index){
    listOfProjects.removeAt(index);
    notifyListeners();
  }

  updateProjectListFromServer()async{
  listOfProjects= await helperFunction.getAllProjectDetails();
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

  addToUniqueList(text, key) {
    print("func called");
    listOfMessagesNotifier.add(text);
    notifyListeners();
    // SecureStorageFunction.saveDataToSharedPref(listOfMessagesNotifier, key);
  }

  addToUniqueListFromServer(text,String type,String from,String fileName,timeStamp) async {
    // listOfMessagesNotifier=[{"msg":"first text"}];
    var newMessage = {
      "msg": text,
      "by": "notme",
      "type": type,
      "fileName": fileName,
      "timeStamp": timeStamp.toString()
    };
    print(newMessage);
    if (key == from) {
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
  removingMessage(int index,String key){
    print("removing a message function");
    listOfMessagesNotifier.removeAt(index);
    notifyListeners();
   // SecureStorageFunction.saveDataToSharedPref(listOfMessagesNotifier, key);
    //send a notification to remove
  }
  removingMessageFromServer(String timeStamp,String from) async {
    print("removing message from server");
    if (key == from) {
      listOfMessagesNotifier.removeWhere((element) =>
      element["timeStamp"] == timeStamp);
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
}
