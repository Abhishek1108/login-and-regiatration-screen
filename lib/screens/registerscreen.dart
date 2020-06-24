
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:registerlogin/screens/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registerlogin/utils/db.dart';
import 'package:registerlogin/models/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart';
import 'dart:async';


class registerScreen extends StatefulWidget {
  @override
  _registerScreenState createState() => _registerScreenState();
}


class _registerScreenState extends State<registerScreen> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _loginfacebook() async {

    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController pass =TextEditingController();
  _login(){
    user us =new user(name.text ,email.text, pass.text);

    Future<DocumentReference> docref= db.addUser(us);
    docref.then((result){

      setState(() {
        print("record added successfully ${result.documentID}");
      });
    }).catchError((err){
      print("Error During Add $err");
    });
  }

  bool _isLoggedIn=false;
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
                      child:Text("Register",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 35,color: Colors.black87),)
                  ),
                  Positioned(
                      top:media.height*0.20,
                      left: media.width*0.03,
                      child:Text("Lets get",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.grey),)
                  ),
                  Positioned(
                      top:media.height*0.24,
                      left: media.width*0.03,
                      child:Text("you on board",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 25,color: Colors.grey),)
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
                  TextField(
                    controller: name,

                    decoration: InputDecoration(

                        hintText: "Full Name",
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
                    height: media.height*0.03,
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
                    child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 30),),
                    onPressed:(){
                     _login();
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
                      _loginfacebook();
                      },
                    ),
                  ),
                 Positioned(
                   top:media.height*0.12,
                   child: Text("Already have account?",style: TextStyle(color:Colors.grey,fontSize: 20),),
                 ),
                  Positioned(
                    top:media.height*0.10,
                    left: media.width*0.52,
                    child: FlatButton(
                      child: Text("Sign in",style: TextStyle(color:Colors.blue,fontSize: 20),),

                      onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>loginscreen()));
                      },
                    ),
                  )

                ],
              ),
            )

          ],
        ),

      ),
    );
  }
}
