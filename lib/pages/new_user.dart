import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Register extends StatelessWidget {

  static final _formKey = GlobalKey<FormState>();
  static final TextEditingController _phoneTextController = TextEditingController();
  static final TextEditingController _idTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  // ======================= PHONE NUMBER =======================

                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.4),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _phoneTextController,
                          decoration: InputDecoration(
                            hintText: "Phone number",
                            icon: Icon(Icons.phone),
                          ),
                          validator: (value) {
                            if (value.length != 10) {
                              print("im here");
                              return "Invalid Phone Number";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

//               ================== ID ====================

                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white.withOpacity(0.4),
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: TextFormField(
                          controller: _idTextController,
                          decoration: InputDecoration(
                            hintText: "BITS ID",
                            icon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value.length != 13) {
                              return "Invalid ID Number";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  // ========================= Register ==========

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue.shade700,
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async{
                            if(_formKey.currentState.validate()) {
                            _setph();
                            FirebaseUser user = await FirebaseAuth.instance.currentUser();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home(user)));
                          }},
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );


  }

  _setph() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('phno', _phoneTextController.text);
    await preferences.setString('ID', _idTextController.text);
    print(preferences.getString('phno'));
  }
}
