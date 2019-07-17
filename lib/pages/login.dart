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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    final GoogleSignInAccount gsa = await googleSignIn.signIn();
    final GoogleSignInAuthentication gs = await gsa.authentication;
    final FirebaseAuth _finalAuth = FirebaseAuth.instance;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: gs.idToken, accessToken: gs.accessToken);

    try {
      FirebaseUser user = await _finalAuth.signInWithCredential(credential);
      if (user != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String phno = preferences.getString('phno');
        String ID = preferences.getString('ID');
        //print("im here");
        //print(phno.toString());
        //print(ID);
        if (user.email.split("@")[1] == "goa.bits-pilani.ac.in" || user.email == "ctebitsgoa@gmail.com") {
          if (phno == "") {
            print(phno);
            //Register();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Register()));
          }
          else
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home(user)));
        }
      } else
        _nonbits();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _nonbits() {
    return AlertDialog(
      title: Text("Alert!"),
      content: Text("Please sign in with your bits mail"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
