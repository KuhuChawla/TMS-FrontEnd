import 'package:http/http.dart' as http;
//import 'package:learning_notifications/constants.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_management_software/constants.dart';


class HelperFunction{

 // final FirebaseAuth _auth=FirebaseAuth.instance;
  // User1 _userFromFirebaseUser(User? user){                    //didn't get this, need to work on it
  //   return user!=null ? User1(userId: user.uid):null;
  // }
  // Future signUpWithEmailAndPassword(String email, String password) async{
  //   try{
  //     UserCredential result= await _auth.createUserWithEmailAndPassword
  //       (email: email, password: password);
  //     User? firebaseUser =result.user;
  //     return firebaseUser;
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }
  // Future signInWithEmailAndPassword(String email, String password) async{
  //   try{
  //     UserCredential result = await _auth.signInWithEmailAndPassword //usercredential is built in imported package
  //       (email: email, password: password);
  //     User? firebaseUser= result.user;
  //     return firebaseUser;
  //   }catch(e){
  //     print(e.toString());
  //
  //   }
  // }


  sendNotification(String? token,String? message,String? name,String type,String fileName, timeStamp) async{
    print("$token $message $name");
    print("Sending notification function");
    if(type=="unsend"){
      print("the type is unsend");
      print(" $token, $message,$name, $type, $fileName, $timeStamp");
    }
    if(message!=""||type=="unsend"){
      http.Response response=await http.get(Uri.parse(
          "https://node-notification.herokuapp.com/sendToken?token="
              "$token&message=$message&name=${Constants.email}&type=$type&fileName=$fileName&timeStamp=${timeStamp.toString()}"));
      print('notification sent');
      print('your response is ${response.statusCode}');
    }
  }

  sendDeviceTokenToDatabase() async{
    var url=Uri.parse("https://ems-heroku.herokuapp.com/tokens");
    var dataToSend={
      "name":  "Rohit",
      "token":"efOjZLfxSKCs7NneDEDZNN:APA91bG0ctBRv5gJPvfQ5jqpQAcbtCbRFN3v-uTUq9oMzGMsZACGDnQgcH7FwLs32UUnPNfQ3wUhR5aHxRyZvkAWMeHm_UuaUByaF3n_PL6RQbe6RLd-ucuvYJ2luO3e9g9QUo-Sqreb",
    };
    var finalData=jsonEncode(dataToSend);
    await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: finalData
    );

  }
  Future getAllTokens()async{
    http.Response response=await http.get(Uri.parse("https://ems-heroku.herokuapp.com/tokens"));
    String data=response.body;
    var finalData=jsonDecode(data);
    //print("this is from handler$finalData");
    return finalData;
  }


  sendNotificationTrial(String? token,String? message,String? name) async{
    print("$token $message $name");
    print("Sending notification function");
    // if(type=="unsend"){
    //   print("the type is unsend");
    //   print(" $token, $message,$name);
    // }
    // if(message!=""||type=="unsend"){
      http.Response response=await http.get(Uri.parse(
          "https://ems-heroku.herokuapp.com/tokens/sendNotification?token="
              "$token&message=$message&name=$name"));
      print('notification sent');
      print('your response is ${response.statusCode}');
   // }
  }

  Future getAllProjectDetails()async{
    http.Response response=await http.get(Uri.parse("https://ems-heroku.herokuapp.com/projects"));
    var data=response.body;
    var finalData=jsonDecode(data);
   // print(finalData["message"]);
    return finalData["message"];
  }

  Future addProjectToDatabase()async{
    print("adding a project was called");
    var url=Uri.parse("https://ems-heroku.herokuapp.com/projects");
    var dataToSend={
     "name":"projectTrial",
      "description":"nothing much",
      "githubLink":"github ka link",
      "documentLink":"document ka link",
      "googleDriveLink":"drive ka link"
    };
    var finalData=jsonEncode(dataToSend);
    await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: finalData
    );
  }

}
//"https://node-notification.herokuapp.com/sendToken?token=$token&message=$message&name=$name"
//http://192.168.29.199:4000?token=$token&message=$message&jsonDataTrial=$finalJsonData
//http://192.168.29.199:4000?token=cNPOWQRrScGMigqHfK6E15:APA91bEgwAvG1dKISZ-QnvOgphVH7I2ri2sle8AoZT0laHIyjCe83FpOg6ttsirL15QaYsUyXL2yJDEYuT8rhSK2HcJCDYHj6kYt8xxu1Y8bN0Xm0fzyvDUFR2LR5Ak0rMwcgV3LG0g7&message=meramsg&name=rohit