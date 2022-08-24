import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/water_model.dart';

class WaterContainer extends StatefulWidget {
  final int weight;
  final int intakeGoal;

  WaterContainer(this.weight, this.intakeGoal);

  @override
  State<WaterContainer> createState() => _WaterContainerState();
}

class _WaterContainerState extends State<WaterContainer> {
  postWaterDetails() {
    try {
      WaterModel waterModel = WaterModel();
      waterModel.time = Timestamp.fromDate(DateTime.now());
      waterModel.millLiters = 200;

      FirebaseFirestore.instance
          .collection('user')
          .doc(user?.uid)
          .collection('water-model')
          .doc()
          .set(waterModel.toMap());
      Fluttertoast.showToast(msg: "Addition Successful");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  User? user;

  double idealIntake = 0;
  double intakePercentage = 0;
  int length = 0;

  getSizes() {
    intakePercentage = ((length * 200) / widget.intakeGoal) * 100;
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getSizes();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(user?.uid)
            .collection('water-model')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4FA8C5)),
              ),
            );
          }
          length = (snapshot.data!.docs.length);
          getSizes();
          return Container(
            height: height * 0.3,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xffF1F7F9),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 205,
                  width: 85,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height *
                            (intakePercentage / 410)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xff245F81),
                                Color(0xff4FA8C5),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 233,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "200 ml",
                        style: TextStyle(
                          color: Color(0xff393939),
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${length * 200}",
                            style: TextStyle(
                              color: Color(0xff4FA8C5),
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "/${widget.intakeGoal}",
                            style: TextStyle(
                              color: Color(0xff393939),
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "ml",
                            style: TextStyle(
                              color: Color(0xff393939),
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "You have completed ${intakePercentage.toStringAsFixed(0)}% of your Daily Target",
                        maxLines: 2,
                        style: TextStyle(
                          color: Color(0xff393939),
                          fontSize: 18,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Color(0xff4FA8C5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                if (length * 200 < widget.intakeGoal) {
                                  postWaterDetails();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'You have completed your goal');
                                }
                              },
                              minWidth: 200.0,
                              height: 42.0,
                              child: Container(
                                width: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.glassWater,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Add water',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
