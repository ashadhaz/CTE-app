import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './course_details.dart';
import './login.dart';
//import './new_user.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  Home(this.user);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final imgSrc = 'images/flut.jpg';
  TabController controller;

  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _checkPh() async {
    /*SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('phno', "");
    preferences.setString('ID', "");
    print("im here");
*/
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                child: AppBar(
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
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: "Register",
                      ),
                      Tab(text: "My courses"),
                    ],
                    labelStyle: TextStyle(fontSize: 25),
                    labelColor: Colors.black,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height-170,
                child: TabBarView(
                  children: [
                    _getCourses(),
                    _myCourses(),
                  ],
                ),
              ),
              SizedBox(
                height: 160,
              )
            ],
          ),
        ),
      ),
    );

    /*
      DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("CTE"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Register",
              ),
              Tab(text: "My courses"),
            ],
            labelStyle: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.lock_open),
              onPressed: () {
                _checkPh();
              },
            )
          ],
        ),
        body: TabBarView(children: [_getCourses(), _myCourses()]),

        //TabBarView(children: [_getCourses(), _myCourses()]),
      ),
    );
    */
  }

  ////////////////// UNTOUCHED //////////////////
  /*
  _getCourses() {
    return ListView(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Courses').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                default:
                  return Column(
                    children:
                        snapshot.data.documents.map((DocumentSnapshot snap) {
                      // _listCourses(snap);
                      return Hero(
                        tag: snap["Name"],
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CourseDetails(
                                        courseImg: imgSrc,
                                        name: snap["Name"],
                                        instructors: snap["Instructors"],
                                        desc: snap["Overview"],
                                        user: widget.user,
                                      )));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                elevation: 10.0,
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        imgSrc,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      bottom: 20,
                                      child: Text(snap["Name"],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      );
                    }).toList(),
                  );
              }
            }),
      ],
    );
  }
   */
  //////////////// EXPERIMENT //////////////
  _getCourses() {
    return ListView(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Courses').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                default:
                  return Column(
                    children:
                        snapshot.data.documents.map((DocumentSnapshot snap) {
                      // _listCourses(snap);
                      return Hero(
                        tag: snap["Name"],
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CourseDetails(
                                        courseImg: imgSrc,
                                        name: snap["Name"],
                                        instructors: snap["Instructors"],
                                        desc: snap["Overview"],
                                        user: widget.user,
                                      )));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                  elevation: 10.0,
                                  child: Container(
                                    height: 450,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "./images/flut.jpg")),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            snap["Name"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            snap["Overview"],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 7,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                      );
                    }).toList(),
                  );
              }
            }),
      ],
    );
  }

  _myCourses() {
    return ListView(
      children: [
        StreamBuilder(
          stream: Firestore.instance
              .collection('My Registrations')
              .document(widget.user.email)
              .collection('My Courses')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
            } else {
              return Column(
                children: snapshot.data.documents
                    .map<Widget>((DocumentSnapshot snap) {
                  //CourseCard(snap, imgSrc);
                  //return Text("Hello");
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                      elevation: 10.0,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              imgSrc,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 20,
                            child: Text(snap["Course Name"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  );
                  /*return Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: Image.asset(
                            imgSrc,
                            fit: BoxFit.cover ,
                          ),
                        ),
                        Positioned(
                            left: 10,
                            bottom: 20,
                            child: Text(
                              snap["Course Name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                )*/
                  ;
                }).toList(),
              );
            }
          },
        )
      ],
    );
  }
}
