import 'package:flutter/material.dart';
class afterlogin extends StatefulWidget {
  @override
  _afterloginState createState() => _afterloginState();
}

class _afterloginState extends State<afterlogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Center(
            child: Text("login successfully"),
          )
        )
      ),
    );
  }
}
