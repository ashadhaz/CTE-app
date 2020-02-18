import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './new_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
          iconSize: 30,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('./images/logo.png'),
      ),
      body: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/logo.png'),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  splashColor: Colors.white,
                  onPressed: _handleSignIn,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Sign In with Google",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please use your BITS Mail",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                )
              ],
            )),
      ),
    );
  }

  _handleSignIn() async {
    Dialogs.showLoadingDialog(context, _keyLoader);
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    final GoogleSignInAccount gsa = await googleSignIn.signIn();
    final GoogleSignInAuthentication gs = await gsa.authentication;
    final FirebaseAuth _finalAuth = FirebaseAuth.instance;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: gs.idToken, accessToken: gs.accessToken);

    try {
      //print("im here");


      FirebaseUser user = await _finalAuth.signInWithCredential(credential);

      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

      if (user != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String phno = preferences.getString('phno');
        String ID = preferences.getString('ID');
        //print("im here");
        //print(phno.toString());
        //print(ID);
        if (user.email.split("@")[1] == "goa.bits-pilani.ac.in" ||
            user.email == "ctebitsgoa@gmail.com") {
          if (phno == null || phno == "") {
            print(phno);
            //Register();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Register()));
          } else
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home(user)));
        }
        return user;
      }
    } catch (e) {
      AlertDialog(
        content: Text(e.toString()),
        actions: <Widget>[
          FlatButton(
              child: Text(e.toString()),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      );
    }
  }
}


class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Loading....",style: TextStyle(color: Colors.black),)
                      ]),
                    )
                  ]));
        });
  }
}