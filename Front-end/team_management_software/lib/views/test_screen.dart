import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../change_notifier.dart';
import '../../constants.dart';

class CreateNewProject2 extends StatefulWidget {
  const CreateNewProject2({Key? key}) : super(key: key);

  @override
  State<CreateNewProject2> createState() => _CreateNewProject2State();
}

class _CreateNewProject2State extends State<CreateNewProject2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController githubLinkController = TextEditingController();
  TextEditingController docLinkController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  validateAndAddProject() {
    var form = formKey.currentState?.validate();
    if (form!) {
      var projectDetails={
        "name":nameController.text,
        "description":descriptionController.text,
      };
      context.read<Data>().addProjectToList(projectDetails);
      Navigator.pop(context);
    }
  }

  showSnackBArForProjectError() {
    final snackBar = SnackBar(
      content: Text("Enter Required Fields"),
      duration: Duration(milliseconds: 800),
      // width: 200,
      margin: EdgeInsets.only(
          left: 40, right: MediaQuery.of(context).size.width - 250, bottom: 5),
      //  backgroundColor: Colors.yellow[800],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),

      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Container(
                //height: MediaQuery.of(context).size.height / 1.18,
                child: TextField(),
                  // Container(
                  //   color: const Color(
                  //       0xFF737373), // this color is similar to the color of non focused area
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(25.0),
                  //             topRight: Radius.circular(25.0))),
                  //     child: Column(
                  //       // mainAxisSize: MainAxisSize.max,
                  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: <Widget>[
                  //         Container(
                  //           padding:
                  //           EdgeInsets.only(top: 0, left: 50, right: 50),
                  //           child: Form(
                  //             key: formKey,
                  //             child: Column(
                  //               children: [
                  //                 const Text(
                  //                   "_____",
                  //                   style: TextStyle(
                  //                       color: Colors.grey,
                  //                       fontSize: 10,
                  //                       fontWeight: FontWeight.bold),
                  //                 ),
                  //                 Container(
                  //                   padding:
                  //                   EdgeInsets.only(top: 12, bottom: 20),
                  //                   child: Text(
                  //                     "Add New Project",
                  //                     style: TextStyle(
                  //                         wordSpacing: 3,
                  //                         fontSize: 23,
                  //                         color: Colors.yellow[800],
                  //                         fontWeight: FontWeight.w300),
                  //                   ),
                  //                 ),
                  //                 //SizedBox(height: 20),
                  //                 TextFormField(
                  //                   autofocus: true,
                  //                   controller: nameController,
                  //                   validator: (val) {
                  //                     if (val != null) {
                  //                       if (val.length < 1) {
                  //                         showSnackBArForProjectError();
                  //                       }
                  //                     }
                  //                   },
                  //                   decoration: Constants
                  //                       .kTextFormFieldDecorationForFProject(
                  //                       "PROJECT NAME *"),
                  //                 ),
                  //                 TextFormField(
                  //                   validator: (val) {
                  //                     if (val != null) {
                  //                       if (val.length < 1) {
                  //                         showSnackBArForProjectError();
                  //                       }
                  //                     }
                  //                   },
                  //                   controller: descriptionController,
                  //                   decoration: Constants
                  //                       .kTextFormFieldDecorationForFProject(
                  //                       "DESCRIPTION *"),
                  //                 ),
                  //                 TextFormField(
                  //                   controller: githubLinkController,
                  //                   decoration: Constants
                  //                       .kTextFormFieldDecorationForFProject(
                  //                       "GITHUB LINK"),
                  //                 ),
                  //                 TextFormField(
                  //
                  //                   controller: docLinkController,
                  //                   decoration: Constants
                  //                       .kTextFormFieldDecorationForFProject(
                  //                       "DOCUMENT LINK"),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             Container(
                  //               padding: EdgeInsets.only(
                  //                 bottom: 5,
                  //                 right: 20,
                  //               ),
                  //               child: RawMaterialButton(
                  //                 onPressed: () {
                  //                   validateAndAddProject();
                  //                 },
                  //                 fillColor: Colors.yellow[800],
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(12)),
                  //                 child: const Text(
                  //                   "Create",
                  //                   style: TextStyle(
                  //                       fontSize: 20,
                  //                       fontWeight: FontWeight.w300),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                );

            },
          );
        },
        child: Icon(
          Icons.create,
          color: Colors.yellow[800],
          size: 35,
        ));
  }
}
