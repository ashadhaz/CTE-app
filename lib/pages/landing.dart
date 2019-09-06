import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './login.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(

          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Image.asset('./images/logo.png'),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              color: Color(0xFF1b1e44),
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Fostering Technical Culture.',
                      style: TextStyle(color: Colors.white, fontSize: 44),
                      children: <TextSpan>[
                        TextSpan(text: '\n'),
                        TextSpan(
                            text: 'Since 2012',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 24))
                      ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "What we do",
                    style: TextStyle(color: Colors.black, fontSize: 32),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 5,
                width: 250,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Text(
                "Center for Technical Education is a technical organisation of BITS Pilani, Goa Camus. Our motive is to enhance the technical culture on campus. We conduct courses and workshops, host technical competitions, offer financial assistance to technical clubs and projects and organize academic help sessions",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  head("Courses"),
                  body(
                      "Our longest running and most successful venture, courses is a great resource to expand your knowledge. Courses on a very wide array of topics ranging from music theory to robotics are taken by highly skilled and dedicated instructors from BITS goa who wish to pass on their knowledge and actively participate in the growth of campus tech culture"),
                  head("AAP"),
                  body(
                      "A relatively new initiative, the Academic Assistance Programme has been a huge success in helping the students of BITS Goa grasp concepts, cover difficult problems and achieve excellence in class courses. The initiative empowers students to ask doubts and encounter problems under the guidance of highly motivated student mentors"),
                  head("Tech Weekend"),
                  body(
                      "To promote the technical culture on campus, CTE, in collaboration with other technical clubs on campus, organizes a weekend filled with hackathons and competitions. These events range from fields like finance to aero-space and helps students relax while encouraging healthy competition"),
                  head("Schooling"),
                  body(
                      "Breaking boundaries and expectations as we expand beyond the walls of our campus and take up workshops and educational seminars in nearby schools, providing students with an early insight and piquing their interest in the current scenario of the technical world and it’s many opportunities"),
                  head("CCE"),
                  body(
                      "CTE has extended it’s reach beyond technical courses as it introduces cultural courses like music and drama to it’s catalogue. This new initiative has seen wide ranging support and is bound to reach new heights as more and more clubs and departments join the initiative"),
                  head("Project Fundings"),
                  body(
                      "At Center for Technical Education, we believing in lending active support to creativity and innovation. CTE funds upto 10 projects with support upto Rs 40,000 to help student teams contribute to the development of technical culture on campus."),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Our team",
                    style: TextStyle(color: Colors.black, fontSize: 32),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 5,
                width: 150,
                color: Colors.green,
              ),
            ),
            team("Chinu", "Pranav"),
            team("Aditya", "Bhavyam"),
            team("anshuman", "PranavP"),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
              child: Image.asset("./images/2019.jpg"),
            )
          ],
        ),
      ),
    );
  }

  Widget head(String head) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        head,
        style: TextStyle(color: Colors.black, fontSize: 28),
      ),
    );
  }

  Widget body(String t) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 14, bottom: 10),
      child: Text(
        "Our longest running and most successful venture, courses is a great resource to expand your knowledge. Courses on a very wide array of topics ranging from music theory to robotics are taken by highly skilled and dedicated instructors from BITS goa who wish to pass on their knowledge and actively participate in the growth of campus tech culture",
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }

  Widget avatar(String s) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 150,
        width: 150,
        padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(image: AssetImage('./images/' +s + '.jpg'), fit: BoxFit.fill),
          ),
      ),
    );
  }

  Widget team(String s1, String s2){
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[avatar(s1), avatar(s2)],
        ),
      ),
    );
  }
}
