import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:registerlogin/screens/registerscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registerlogin/utils/db.dart';
import 'package:registerlogin/screens/afterlogin.dart';
import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart';

class loginscreen extends StatefulWidget {
  @override
  _loginscreenState createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController email= TextEditingController();
  TextEditingController pass= TextEditingController();



  _checkData(){


    Future<QuerySnapshot> future =db.readAllRecords();
    future.then((snapshot){
      snapshot.documents.forEach((record){
       // print(record.data);
        if(record.data["email"]==email.text&&record.data["pass"]==pass.text){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>afterlogin()));

        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>registerScreen()));
        }
      });
    });
  }




  GoogleSignIn _googleSignIn=GoogleSignIn(scopes:["email"] );
  _googleLogin() async{
    await _googleSignIn.signIn();

  }


  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
      children: <Widget>[
      Container(
      height: media.height/3,
      width: double.infinity,

      child: Stack(
        children: <Widget>[
          Positioned(
              top:media.height*0.10,
              left: media.width*0.03,
              child:Text("Login",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 35,color: Colors.black87),)
          ),
          Positioned(
              top:media.height*0.20,
              left: media.width*0.03,
              child:Text("Welcome back,",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.grey),)
          ),
          Positioned(
              top:media.height*0.24,
              left: media.width*0.03,
              child:Text("please login",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.grey),)
          ),
          Positioned(
              top:media.height*0.28,
              left: media.width*0.03,
              child:Text("to your account",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.grey),)
          ),
        ],
      ),
    ),
               Container(
              height: media.height/3,
               width: media.width*0.90,
    // color:Colors.blueAccent,
              child: Column(
              children: <Widget>[

                      SizedBox(
    height: media.height*0.03,
    ),
    TextField(
      controller: email,
    decoration: InputDecoration(
    hintText: "Email",
    hintStyle: TextStyle(color: Colors.grey
    ),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
    color: Colors.black87
    )

    )
    ),
    ),
    SizedBox(
    height: media.height*0.07,
    ),
    TextField(
      controller: pass,
    obscureText: true,
    decoration: InputDecoration(
    hintText: "Password",
    hintStyle: TextStyle(color: Colors.grey
    ),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
    color: Colors.black87
    )

    )
    ),
    ),
                Padding(
                  padding: const EdgeInsets.only(left:150),
                  child: FlatButton(
                    child: Text("Forgot Passward ?",style: TextStyle(color: Colors.blue
                    ),),
                  ),
                )

    ],
    ),

    ),

    Container(
    height: media.height*0.07,
    width: media.width*0.85,



    child: ButtonTheme(

    height: 50,
    buttonColor: Colors.blue,
    child: RaisedButton(
    elevation: 5,
    child: Text("login",style: TextStyle(color: Colors.white,fontSize: 30),),
    onPressed:(){
        _checkData();
    }),
    ),

    ),Padding(
    padding: const EdgeInsets.all(9.0),
    child: Container(
    height: media.height*0.04,

    // color: Colors.blueAccent,
    child: Text("_____ Or _____",style: TextStyle(color: Colors.black87,fontSize: 15
    ),),
    ),
    ),
        Container(
          height: media.height/3,
          width:media.width*0.90,
          // color: Colors.blue,
          child: Stack(
            children: <Widget>[
              Positioned(

                child: GoogleSignInButton(
                  text: "google",
                  textStyle: TextStyle(fontSize: 20),

                  onPressed: (){
                   _googleLogin();
                  },
                ),

              ),
              Positioned(
                left:media.width*0.50,
                child: FacebookSignInButton(

                  //splashColor: Colors.white,
                  text: "facebook",
                  textStyle: TextStyle(fontSize: 20),
                  onPressed: (){

                  },
                ),
              ),
              Positioned(
                top:media.height*0.12,
                child: Text("don't have an account?",style: TextStyle(color:Colors.grey,fontSize: 20),),
              ),
              Positioned(
                top:media.height*0.10,
                left: media.width*0.52,
                child: FlatButton(
                  child: Text("Sign up",style: TextStyle(color:Colors.blue,fontSize: 20),),

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>registerScreen()));
                  },
                ),
              )

            ],
          ),
        )
    ]
    )
    )
    );
  }
}
