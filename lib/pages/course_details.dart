import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseDetails extends StatefulWidget {
  final String courseImg, desc, instructors, name;
  final FirebaseUser user;

  CourseDetails(
      {this.courseImg, this.desc, this.instructors, this.name, this.user});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  String butText = "R";

  @override
  void initState() {
    super.initState();
    buttonSet();
  }

  void buttonSet() {
    Firestore db = Firestore.instance;
    final ref1 = db
        .collection('Registrations')
        .document(widget.user.email)
        .collection(widget.name);
    ref1.getDocuments().then((doc) {
      if (doc.documents.length != 0) {
        setState(() {
          butText = "Registered";
        });
      } else {
        setState(() {
          butText = "Register Now";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MaterialButton(
        minWidth: MediaQuery.of(context).size.width - 35,
        elevation: 10.0,
        splashColor: Colors.white,
        highlightColor: Colors.white,
        disabledColor: Colors.green,
        onPressed: butText == "Registered" ? null : _handleRegistration,
        color: Colors.blue,
        textColor: Colors.white,
        child: butText == "R"
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                butText,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
      /*appBar: AppBar(
        title: Text(widget.name),
      ),*/
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(widget.name),
            expandedHeight: 200,
            floating: true,
            flexibleSpace: Hero(
              tag: widget.name,
              child: Image.asset(
                widget.courseImg,
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            //floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Instructors:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child:
                      Text(widget.instructors, style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, bottom: 6, top: 10),
                  child: Text(
                    "Overview",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 10),
                  child: Text(widget.desc, style: TextStyle(fontSize: 18)),
                ),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleRegistration() async {
    setState(() {
      butText = 'R';
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    Firestore db = Firestore.instance;

    final ref = db.collection('Registrations').document(widget.user.email);
    final ref2 = db.collection('My Registrations').document(widget.user.email);
    ref.get().then((doc) {
      if (!doc.exists) {
        db
            .collection('Registrations')
            .document(widget.user.email)
            .setData({"No of courses": 0});
      }
    });

    final ref1 = db
        .collection('Registrations')
        .document(widget.user.email)
        .collection(widget.name);
    ref1.getDocuments().then((doc) {
      if (doc.documents.length != 0) {
        setState(() {
          butText = "Registered";
        });
        return null;
      } else {
        ref2.get().then((doc) {
          if (!doc.exists) {
            db
                .collection('My Registrations')
                .document(widget.user.email)
                .setData({"a": 0});
          }
        });

        db
            .collection('My Registrations')
            .document(widget.user.email)
            .collection('My Courses')
            .document(widget.name)
            .setData({
          "Name": widget.user.displayName,
          "Course Name": widget.name,
          "Email ID": widget.user.email,
          "Phone number": preferences.getString('phno'),
          "ID": preferences.getString('ID'),
        });

        db
            .collection('Registrations')
            .document(widget.user.email)
            .collection(widget.name)
            .document(widget.name)
            .setData({
          "Name": widget.user.displayName,
          "Course Name": widget.name,
          "Email ID": widget.user.email,
          "Phone number": preferences.getString('phno'),
          "ID": preferences.getString('ID'),
        }).then((c) {
          db
              .collection('Registrations')
              .document(widget.user.email)
              .updateData({"No of courses": FieldValue.increment(1.0)});

          setState(() {
            butText = "Registered";
          });
        });
      }
    });
  }
}
