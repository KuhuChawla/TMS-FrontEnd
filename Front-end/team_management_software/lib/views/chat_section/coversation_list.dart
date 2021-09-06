import 'package:flutter/material.dart';
// import 'package:learning_notifications/constants.dart';
// import 'package:learning_notifications/function_handler.dart';
// import 'package:learning_notifications/sign_in.dart';
// import 'package:learning_notifications/push_notifications.dart';
// import 'package:learning_notifications/shared_pref_functions.dart';
// import 'package:learning_notifications/testing_shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:team_management_software/controller/helper_function.dart';

import '../../change_notifier.dart';
import 'chatting_screen.dart';
// import 'change_notifier.dart';

// ignore: use_key_in_widget_constructors
class ConversationListPage extends StatefulWidget {
  @override
  _ConversationListPageState createState() => _ConversationListPageState();
}

var thisIsList = [];

class _ConversationListPageState extends State<ConversationListPage> {
  String? token;
  //bool isLoading = true;
  HelperFunction helperFunction = HelperFunction();
  gettingTheTokens() async {
    thisIsList = context.watch<Data>().listOfTokensNotifier;
  }
  getDeviceToken()async{
 //   token = await FirebaseNotification().getToken();
  }
  @override
  void initState() {
    getDeviceToken();
    //context.read<Data>().updateTokenListFromSharedPref();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    gettingTheTokens();
   // Provider.of<Data>(context, listen: false).getTokensDataFromHttp();
     context.read<Data>().getTokensDataFromHttp();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFFe1ecf7),
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 20, top: 2),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    //SizedBox(width: 12,),
                    const Expanded(
                      child: Text(
                        "Conversations",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // SharedPrefFunctions.setIsUserLoggedIn(false);
                        // SharedPrefFunctions.saveEmail("");
                       // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        // //      return SignInPage();
                        //     }));
                        //print("this is username ${Constants.username}");

                        // helperFunction.sendDeviceTokenToDatabase();
                        helperFunction.sendNotificationTrial("efOjZLfxSKCs7NneDEDZNN:APA91bG0ctBRv5g"
                            "JPvfQ5jqpQAcbtCbRFN3v-uTUq9oMzGMsZACGDnQgcH7FwLs32UUnPNf"
                            "Q3wUhR5aHxRyZvkAWMeHm_UuaUByaF3n_PL6RQbe6RLd-ucuvYJ2luO3e9g9QUo-Sqreb", "hi bro", "Rohit");
                        print("sent");
                      },
                      icon: const Icon(
                        Icons.login_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),

                    //Icon(Icons.settings, color: Colors.black54,),
                  ],
                ),
              ),
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: thisIsList.length,
            itemBuilder: (context, index) {
              return
                // thisIsList[0]["name"] == null ||thisIsList[index]["token"]==token
                //     ? Container(
                //   child: Text("empty"),
                // )
                //     :
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChattingScreen(
                              thisIsList[index]["token"],
                              thisIsList[index]["name"])),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: UserTile(thisIsList[index]["name"]!)

                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}

UserTile(String name) {
  return Container(
    padding: const EdgeInsets.only(
      right: 10,
    ),
    child: Row(
      children: <Widget>[
        const SizedBox(
          width: 2,
        ),
        const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png"),
          maxRadius: 20,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 6,
              ),
              // Text("Online", style: TextStyle(
              //     color: Colors.grey.shade600, fontSize: 13),),
            ],
          ),
        ),
      ],
    ),
  );
}
