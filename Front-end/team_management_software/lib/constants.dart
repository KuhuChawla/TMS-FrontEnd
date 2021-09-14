import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Constants{
  static  kTextFormFieldDecoration(String labelText){
    return InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.grey),
        focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow[800]!)));
  }
  static  kTextFormFieldDecorationForFProject(String labelText){
    return InputDecoration(
        labelText: labelText,
        labelStyle:  const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            color: Colors.grey),
        focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow[800]!)));
  }
  static Color buttonColor=   const Color(0xFFeccf1d);
  static String username="testEmail";
  static String email="";
}