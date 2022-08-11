import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_reminder/models/water_model.dart';

import '../models/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool messageVisible = false;
  final quantityController = TextEditingController();

  double sWidth = 0;

  double sHeight = 0;

  int weight = 0;
  double idealIntake = 0;

  User? user;
  TimeOfDay timeToDrink = TimeOfDay.now();

  FirebaseAuth _auth = FirebaseAuth.instance;

  getData() async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('user-info')
          .snapshots()
          .listen((event) {
        weight = event.docs.first.get('weight');
        if (!mounted) return;
        setState(() {
          idealIntake = (weight * 0.1 * 2.20462);
        });
        print(idealIntake);
        print(weight);
      });
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    sWidth = MediaQuery.of(context).size.width;
    sHeight = MediaQuery.of(context).size.height;
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
            Container(
              height: 237,
              width: 321,
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
                          height: MediaQuery.of(context).size.height * 0.001,
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
                          "250 ml",
                          style: TextStyle(
                            color: Color(0xff393939),
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "800",
                              style: TextStyle(
                                color: Color(0xff4FA8C5),
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "/${idealIntake.toStringAsFixed(0)}",
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
                          "You have completed 30% of your Daily Target",
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
                                  addAlertDialogue(context, idealIntake);
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
            ),
          ],
        ),
      ),
    );
  }

  addAlertDialogue(BuildContext context, double intake) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                title: Text("Add Water"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          }
                          if (value == "0") {
                            return "Quantity can not be 0";
                          }
                          if (double.parse(value) > intake) {
                            return "This quantity exceeds your intake";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: quantityController,
                        decoration: textFieldDecoration.copyWith(
                          icon: FaIcon(FontAwesomeIcons.water),
                          label: Text(
                            "Water Quantity",
                            style: TextStyle(
                                color: Color(0xff4FA8C5), fontSize: 20),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                TimeOfDay? newTime = await showTimePicker(
                                    context: context, initialTime: timeToDrink);
                                if (newTime == null) return;
                                setState(() {
                                  timeToDrink = newTime;
                                });
                                print(timeToDrink.format(context));
                              },
                              child: Text(
                                "Select Time",
                                style: TextStyle(
                                  color: Color(0xff4FA8C5),
                                ),
                              )),
                          Text(": ${timeToDrink.format(context)}"),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        try {
                          DateTime dt = DateTime.now();
                          final format = DateTime(dt.year, dt.month, dt.day,
                              timeToDrink.hour, timeToDrink.minute);
                          WaterModel waterModel = WaterModel();
                          waterModel.time = Timestamp.fromDate(format);
                          waterModel.millLiters =
                              int.parse(quantityController.text);
                          print(waterModel.millLiters);

                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(user!.uid)
                              .collection('water-model')
                              .doc()
                              .set(waterModel.toMap());
                          quantityController.clear();
                          Fluttertoast.showToast(msg: "Addition Successful");
                          Navigator.of(context).pop();
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                          print(e);
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Color(0xff4FA8C5),
                        ),
                      )),
                ],
              );
            },
          );
        });
  }

  postWaterDetails() {
    try {} catch (e) {}
  }
}
