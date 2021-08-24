import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:team_management_software/views/sign_in.dart';
// import 'package:learning_notifications/function_handler.dart';
// import 'package:learning_notifications/sign_in.dart';
// import 'package:learning_notifications/mainpage.dart';
// import 'package:learning_notifications/push_notifications.dart';
// import 'package:learning_notifications/shared_pref_functions.dart';
// import 'constants.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  validateAndSignUp() {
    var form = formKey.currentState?.validate();
    if (form!) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(12.sp, 80.sp, 0.0, 0.0),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                          fontSize: 60.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(212.sp, 85.sp, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 30.sp, left: 20.sp, right: 20.sp),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          val ??= " ";
                          return val.length >= 4 ? null : " try a valid email";
                        },
                        decoration: const InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow))),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        controller: passwordController,
                        validator: (val) {
                          val ??= "";
                          return val.length >= 6
                              ? null
                              : "Enter a valid password";
                        },
                        decoration: const InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow))),
                        obscureText: true,
                      ),
                      SizedBox(height: 5.h),
                      GestureDetector(
                        onTap: () {
                          validateAndSignUp();
                        },
                        child: Container(
                            height: 6.2.h,
                            child: Material(
                              borderRadius: BorderRadius.circular(11.sp),
                              shadowColor: Colors.yellowAccent,
                              color: Colors.yellow[500],
                              elevation: 7.0,
                              child: Center(
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                      fontSize: 7.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 2.4.h),
                      Container(
                        height: 6.2.h,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(11.sp)),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                            },
                            child: Center(
                              child: Text('Already have an account? LogIn',
                                  style: TextStyle(
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                )),
          ]),
    ));
  }
}
