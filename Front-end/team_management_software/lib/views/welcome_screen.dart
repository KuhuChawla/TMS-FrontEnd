import 'package:flutter/material.dart';
import 'package:team_management_software/controller/http_functions.dart';
import 'package:team_management_software/views/sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:team_management_software/views/sign_up.dart';
import '../constants.dart';

class WelcomeScreen extends StatelessWidget {
   WelcomeScreen({Key? key}) : super(key: key);
 final HttpFunctions httpFunctions=HttpFunctions();
  @override
  build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
      child: Container(
          // width: double.infinity,
          // height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40.sp, vertical: 50.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: <Widget>[
                Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.sp),
                ),
              ]),
              Container(
                height: 45.h,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("images/LOGO2.png"))),
              ),
              Column(
                children: <Widget>[

                  MaterialButton(
                    color: Constants.buttonColor
                    ,
                    elevation: 7,
                    minWidth: double.infinity,
                    height: 7.h,
                    shape: RoundedRectangleBorder(
                       // side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(14.sp)),
                    onPressed: () async {
                      // var response= await  httpFunctions.signInUser();
                      // print("response from welcome screen $response");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                    },
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold, fontSize: 13.sp),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    child: MaterialButton(
                      color: Colors.white,
                      elevation: 2,
                      minWidth: double.infinity,
                      height: 7.h,

                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(14.sp)),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage() ));
                        // httpFunctions.registerUser(
                        // );
                      },
                      child: Text(
                        "SIGN UP",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
      ),
    ),
        ));
  }
}
