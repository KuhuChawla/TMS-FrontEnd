import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focused_menu/modals.dart';
import 'package:team_management_software/controller/helper_function.dart';
import 'package:team_management_software/views/chat_section/audio_section/soundplayer_class.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:team_management_software/views/chat_section/pdf_page.dart';
import 'package:team_management_software/views/chat_section/tiles/audio_tile.dart';
import 'package:team_management_software/views/chat_section/tiles/message_tile.dart';
import 'package:team_management_software/views/chat_section/tiles/pdt_tile.dart';
import 'package:team_management_software/views/chat_section/tiles/video_tile.dart';
import 'package:team_management_software/views/components/appbar_chat_screen.dart';
import 'package:team_management_software/views/components/loading_indicator.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
 import '../../change_notifier.dart';
import 'audio_section/sound_recorder_class.dart';
import 'audio_section/sound_recorder_ui.dart';
import 'audio_section/soundplayer_ui.dart';
import 'chewie_player.dart';
import 'pdf_api.dart';
import 'package:focused_menu/focused_menu.dart';
// import 'audio_player/audio_player.dart';
// import 'package:learning_notifications/audio_player/sound_player.dart';
// import 'package:learning_notifications/audio_player/sound_player_ui.dart';
// import 'package:learning_notifications/audio_player/sound_recorder.dart';
// import 'package:learning_notifications/function_handler.dart';
// import 'package:learning_notifications/testing_page.dart';

// ignore: must_be_immutable
class ChattingScreen extends StatefulWidget {
  String? token, name;

  // ignore: use_key_in_widget_constructors
  ChattingScreen(this.token, this.name);
  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
 final soundRecorder = SoundRecorder();
  final soundPlayer=SoundPlayer();
  Color? myColor = Colors.green;
  bool isSelected = false;
  bool showRecorder = false;
  bool isLoading = true;
  bool toRefresh = false;
  bool alternativeAppbar = true;
 HelperFunction helperFunction = HelperFunction();

  ScrollController scrollController = ScrollController();
  // ignore: prefer_typing_uninitialized_variables
  var messageJsonDataFormUser;
  var listOfMessages=[];
  //final  picker = ImagePicker();

  pickingFile(String extension) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [extension],
        //'jpg', 'pdf', 'doc'
        allowMultiple: false);
    if (result != null) {
      setState(() {
        showSpinner = true;
      });
      PlatformFile file = result.files.first;
      var anyFile = File(file.path!);
      final filename = path.basename(file.path!);

      await uploadFileToFirebase(anyFile, filename, extension);
    }
  }

  addingMessageToList(
      String text, String type, String fileName, timeStamp) async {
    if (text != "") {
      context.read<Data>().addToUniqueList({
        "msg": text,
        "by": "me",
        "type": type,
        "fileName": fileName,
        "timeStamp": timeStamp.toString()
      }, widget.name!);
    }
  }

  String? abc;
  uploadFileToFirebase(File file, String fileName, String type) async {
    if (file != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      String newString = fileName.replaceAll(" ", "");
      Reference ref = storage.ref().child(newString);
      UploadTask uploadTask = ref.putFile(file);
      await uploadTask.then((res) async {
        abc = await res.ref.getDownloadURL();
        print(abc);
      });
      var timeStamp = DateTime.now().millisecondsSinceEpoch;

      if (type == "jpg") addingMessageToList(abc!, "jpg", fileName, timeStamp);
      if (type == "pdf") {
        addingMessageToList(abc!, "pdf", fileName, timeStamp);
      }
      if (type == "mp4") {
        addingMessageToList(abc!, "video", fileName, timeStamp);
      }
      if (type == "audio" || type == "mp3") {
        print("type audio is getting added");
        addingMessageToList(abc!, "audio", fileName, timeStamp);
      }

      setState(() {
        showSpinner = false;
      });

      // helperFunction.sendNotification(
      //     widget.token,
      //     abc!,
      //     widget.name,
      //     type == "jpg"
      //         ? "image"
      //         : type == "mp4"
      //         ? "video"
      //         : type == "mp3"
      //         ? "audio"
      //         : type,
      //     fileName,
      //     timeStamp.toString());
    }
  }

  @override
  void initState() {
    context.read<Data>().updateMessageListFromSharedPref(widget.name!);
    context.read<Data>().updateKey(widget.name!);
     soundRecorder.init();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //soundRecorder.dispose();
  }
  @override
  void didChangeDependencies() {
    listOfMessages = context.watch<Data>().listOfMessagesNotifier;
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  TextEditingController messageController = TextEditingController();
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    bool enableTextField=true;
    String messageType = "text";

    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
      appBar: getAppBar(context, widget.name!),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: listOfMessages.length,
                          itemBuilder: (context, index) {
                            var length = listOfMessages.length;
                            var currentIndex =
                            listOfMessages[length - index - 1];
                            bool sendByMe = currentIndex["by"] == "me";
                            return Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                left: currentIndex["by"] == "me"
                                    ? MediaQuery.of(context).size.width /
                                    3
                                    : 10,
                                right: currentIndex["by"] == "me"
                                    ? 10
                                    : MediaQuery.of(context).size.width /
                                    3,
                              ),
                              alignment: currentIndex["by"] == "me"
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              child: currentIndex["type"] == "text"
                                  ? Container(
                                // color: isSelected?Colors.red:Colors.blue,
                                child: sendByMe
                                    ? FocusMenuHolderClass(
                                  MessageTile(
                                      text:
                                      currentIndex["msg"],
                                      side: sendByMe
                                          ? "left"
                                          : "right"),
                                  length - index - 1,
                                  widget.name!,
                                  currentIndex["timeStamp"],
                                  widget.token,
                                )
                                    : MessageTile(
                                    text: currentIndex["msg"],
                                    side: sendByMe
                                        ? "left"
                                        : "right"),
                              )
                                  : currentIndex["type"] == "jpg" ||
                                  currentIndex["type"] == "image"
                                  ?
                              //lets its a image
                              sendByMe
                                  ? FocusMenuHolderClass(
                                Container(
                                  //this.widget,this.index,this.name,this.timeStamp,this.token
                                  //height: 300,
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius
                                          .circular(10),
                                      child: Image.network(
                                        "${currentIndex["msg"]}",
                                      )),
                                ),
                                length - index - 1,
                                widget.name!,
                                currentIndex["timeStamp"],
                                widget.token,
                                // helperFunction.sendNotification(widget.token!, "", widget.name!, "unsend", "",
                                // currentIndex["timeStamp"])
                              )
                                  : Container(
                                //height: 300,
                                child: ClipRRect(
                                    borderRadius:
                                    BorderRadius
                                        .circular(10),
                                    child: Image.network(
                                      "${currentIndex["msg"]}",
                                    )),
                              )
                                  : currentIndex["type"] == "pdf"
                                  ?sendByMe?
                              FocusMenuHolderClass(Container(
                                width: 300,
                                height: 100,
                                child: GestureDetector(
                                  onTap: () async {
                                    String url =
                                    currentIndex["msg"]!;
                                   final file =
                                    await PDFApi
                                        .loadNetwork(
                                        url);
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) {
                                              return PdfScreen(
                                                file: file,
                                                fileName:
                                                currentIndex[
                                                "fileName"],
                                              );
                                            }));
                                  },
                                  child: PdfTile(
                                      name: currentIndex[
                                      "fileName"],
                                      side: currentIndex[
                                      "by"] ==
                                          "me"
                                          ? "left"
                                          : "right",
                                      url: currentIndex[
                                      "msg"]),
                                ),
                              ),
                                length - index - 1,
                                widget.name!,
                                currentIndex["timeStamp"],
                                widget.token,)
                                  : Container(
                                width: 300,
                                height: 100,
                                child: GestureDetector(
                                  onTap: () async {
                                    String url =
                                    currentIndex["msg"]!;
                                    final file =
                                    await PDFApi
                                        .loadNetwork(
                                        url);
                                   Navigator.push(context,
                                        MaterialPageRoute(
                                            builder:
                                                (context) {
                                              return PdfScreen(
                                                file: file,
                                                fileName:
                                                currentIndex[
                                                "fileName"],
                                              );
                                            }));
                                  },
                                  child: PdfTile(
                                      name: currentIndex[
                                      "fileName"],
                                      side: currentIndex[
                                      "by"] ==
                                          "me"
                                          ? "left"
                                          : "right",
                                      url: currentIndex[
                                      "msg"]),
                                ),
                              )
                                  : currentIndex["type"] ==
                                  "video"
                                  ?sendByMe?FocusMenuHolderClass( GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (context) {
                                            return ChewiePlayer(
                                              videoPlayerController:
                                              VideoPlayerController
                                                  .network(
                                                  currentIndex[
                                                  "msg"]!),
                                              fileName:
                                              currentIndex[
                                              "fileName"],
                                              looping: true,
                                            );
                                          }));
                                },
                                child: Container(
                                  width: 300,
                                  height: 100,
                                  child: VideoTile(
                                      side: currentIndex[
                                      "by"] ==
                                          "me"
                                          ? "left"
                                          : "right",
                                      name: currentIndex[
                                      "fileName"]),
                                ),
                              ),  length - index - 1,
                                widget.name!,
                                currentIndex["timeStamp"],
                                widget.token,) : GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder:
                                              (context) {
                                            return ChewiePlayer(
                                              videoPlayerController:
                                              VideoPlayerController
                                                  .network(
                                                  currentIndex[
                                                  "msg"]!),
                                              fileName:
                                              currentIndex[
                                              "fileName"],
                                              looping: true,
                                            );
                                          }));
                                },
                                child: Container(
                                  width: 300,
                                  height: 100,
                                  child: VideoTile(
                                      side: currentIndex[
                                      "by"] ==
                                          "me"
                                          ? "left"
                                          : "right",
                                      name: currentIndex[
                                      "fileName"]),
                                ),
                              )
                                  : currentIndex["type"] ==
                                  "audio"
                                  ?sendByMe? FocusMenuHolderClass(GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  showDialog(
                                      context:
                                      context,
                                      builder:
                                          (context) {
                                        return AudioPlayerDialog(
                                          url: currentIndex[
                                          "msg"],
                                        );
                                      });
                                },
                                child: Container(
                                    width: 300,
                                    height: 100,
                                    child: AudioTile(
                                        side: currentIndex["by"] ==
                                            "me"
                                            ? "left"
                                            : "right",
                                        name: currentIndex[
                                        "fileName"])),
                              ), length - index - 1,
                                widget.name!,
                                currentIndex["timeStamp"],
                                widget.token,) : GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    //showSpinner=true;
                                  });
                                  showDialog(
                                      context:
                                      context,
                                      builder:
                                          (context) {
                                        // var isPlaying=soundPlayer.isPlaying;
                                        return AudioPlayerDialog(
                                          url: currentIndex[
                                          "msg"],
                                        );
                                      });

                                },
                                child: Container(
                                    width: 300,
                                    height: 100,
                                    child: AudioTile(
                                        side: currentIndex["by"] ==
                                            "me"
                                            ? "left"
                                            : "right",
                                        name: currentIndex[
                                        "fileName"])),
                              )
                                  : Container(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              showRecorder ? loadingIndicator(context) : Container(),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: TextField(
                          onChanged: (val){

                          },
                          enabled: enableTextField,

                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: "type your message here",
                          ),
                        )),

                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {

                        // setState(() {
                        //   enableTextField=false;
                        // });

                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return SoundRecorderWidget(widget.name,widget.token);
                        //     });
                        var width=MediaQuery.of(context).size.width;
                        var snackBar= SnackBar(
                          duration:Duration(milliseconds: 800),
                          behavior: SnackBarBehavior.floating,

                          margin: EdgeInsets.only(left:width/20,
                            right: width/2.5,
                            bottom: width/8,

                          ),

                          content: Text("Long press to start recording"),backgroundColor: Colors.black,);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      },
                      onLongPressStart: (val) {
                        setState(() {
                          showRecorder = true;
                        });
                        soundRecorder.toggleRecording();
                      },
                      onLongPressEnd: (val) {
                        setState(() {
                          showRecorder = false;
                          soundRecorder.toggleRecording();
                        });

                        showDialog(context: context, builder: (context){
                          return SoundRecorderWidget(widget.name,widget.token);
                        });
                      },
                      child: Container(
                        child: Icon(
                          Icons.mic_none_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(

                      onSelected: (String value) {

                        if (value == "image") {
                          pickingFile("jpg");
                          messageType = "jpg";
                        } else if (value == "pdf") {
                          pickingFile("pdf");
                          messageType = "pdf";
                        } else if (value == "video") {
                          pickingFile("mp4");
                          messageType = "video";
                        } else if (value == "audio") {
                          pickingFile("mp3");
                          messageType = "audio";
                        }
                      },
                      icon: const Icon(
                        Icons.attach_file_outlined,
                        size: 30,
                      ),
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'image',
                          child: Text('image'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'video',
                          child: Text('video'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'pdf',
                          child: Text('pdf file'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'audio',
                          child: Text('audio'),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: RawMaterialButton(
                        onPressed: () {
                          String text = messageController.text;
                          var timeStamp =
                              DateTime.now().millisecondsSinceEpoch;
                          addingMessageToList(
                              text, messageType, " ", timeStamp);
                          messageController.text = "";

                          setState(() {});
                          scrollController.animateTo(0.0,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                          // helperFunction.sendNotification(
                          //     "efOjZLfxSKCs7NneDEDZNN:APA91bG0ctBRv5gJPvfQ5jqpQAcbtCbRFN3v-uTUq9oMzGMsZACG
                          //     DnQgcH7FwLs32UUnPNfQ3wUhR5aHxRyZvkAWMeHm_UuaUByaF3n_PL6RQbe6RLd-ucuvYJ2luO3e9g9QUo-Sqreb",
                          //     text,
                          //     widget.name,
                          //     messageType,
                          //     "",
                          //     timeStamp);
                          helperFunction.sendNotificationTrial(widget.token, text, widget.name);
                          print("sent");
                           //saveDataToSharedPrefs();
                        },
                        child: const Text(
                          "Send",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        //fillColor: Colors.teal[200],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  toggleSelection() {
    setState(() {
      if (isSelected) {
        myColor = Colors.white;
        isSelected = false;
      } else {
        myColor = Colors.grey[300];
        isSelected = true;
      }
    });
  }
}

class FocusMenuHolderClass extends StatelessWidget {
  final Widget widget;
  final String name;
  final int index;
  final timeStamp;
  final token;
// final Future function;
  FocusMenuHolderClass(
      this.widget, this.index, this.name, this.timeStamp, this.token);
  // HelperFunction helperFunction = HelperFunction();

  @override
  Widget build(
      BuildContext context,
      ) {
    return FocusedMenuHolder(
        menuWidth: 100,
        onPressed: () {},
        menuItems: [
          FocusedMenuItem(
            title: const Text(
              "Unsend",
              style: TextStyle(fontSize: 15),
            ),
            onPressed: () {
              // context.read<Data>().removingMessage(index, name);
              // print("this is from the function handler");
              // print(" $token $name $timeStamp");
              // helperFunction.sendNotification(
              //     token, "", name, "unsend", "", timeStamp);
//String? token,String? message,String? name,String type,String fileName, timeStamp
            },
          ),
        ],
        openWithTap: false,
        blurSize: 2,
        child: widget);
  }
}

focusedMenuToSelectFile(){
  return FocusedMenuHolder(
    child: Icon(Icons.attach_file_rounded,size: 30,),
    openWithTap: true,
    menuWidth :200,
    onPressed: (){

    },
    menuItems: [FocusedMenuItem(title: Text("hi"), onPressed: (){

    }),
      FocusedMenuItem(title: Text("hello"), onPressed: (){

      })],
  );
}