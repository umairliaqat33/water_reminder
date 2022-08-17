import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/widgets/list_screen.dart';
import 'package:water_reminder/widgets/water_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool messageVisible = false;

  double sWidth = 0;

  double sHeight = 0;

  int weight = 0;
  double idealIntake = 0;
  int goal=0;

  User? user;
  TimeOfDay timeToDrink = TimeOfDay.now();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    sWidth = MediaQuery.of(context).size.width;
    sHeight = MediaQuery.of(context).size.height;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(user?.uid)
            .collection('user-info')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4FA8C5)),
              ),
            );
          }
          goal=snapshot.data!.docs.first.get('waterIntakeGoal');
          weight = snapshot.data!.docs.first.get('weight');
          idealIntake = (weight * 0.033 * 1000);
          return Scaffold(
            backgroundColor: Color(0xffC6DFE8),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset("images/img_3.png"),
                      Container(
                        width: sWidth * 0.7,
                        height: 64,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xff4FA8C5),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                        ),
                        child: Center(
                          child: Text(
                            "Do not drink cold water immediately after hot drinks",
                            maxLines: 2,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  WaterContainer(weight,goal),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "You Drank",
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: sHeight * 0.33,
                    child: ListScreenWidget(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
