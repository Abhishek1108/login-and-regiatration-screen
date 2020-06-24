import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registerlogin/screens/registerscreen.dart';
import 'package:registerlogin/screens/showdata.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "login",
    home: registerScreen(),

  ),
  );
}