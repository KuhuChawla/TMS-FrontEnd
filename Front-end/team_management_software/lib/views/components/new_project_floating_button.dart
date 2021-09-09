import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../change_notifier.dart';
import '../../constants.dart';


floatingButtonForNewProject(context){
  var input;

  return FloatingActionButton(
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
                          context.read<Data>().addProjectToList(
                              {"name": input});
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
      ));
}
