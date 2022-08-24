import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water_reminder/models/constants.dart';
import 'package:water_reminder/models/data_model.dart';
import 'package:water_reminder/screens/screen_shifter.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final weightController = TextEditingController();
  final sleepTimeController = TextEditingController(text: "--:-- --");
  final wakeTimeController = TextEditingController(text: "--:-- --");
  final waterIntakeGoalController = TextEditingController();
  final pageController = PageController();
  String radioValue = "Male";
  TimeOfDay sleepTime = TimeOfDay.now();
  TimeOfDay wakeTime = TimeOfDay.now();
  final _weightFormKey = GlobalKey<FormState>();
  bool errorMessage = false;
  bool timeError = false;
  final finalKey = GlobalKey<FormState>();
  User? user;


  postUserDetailsToFireStore(String gender, int weight, TimeOfDay sleepTime,
      TimeOfDay wakeTime) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      WeightModel weightModel = WeightModel();
      weightModel.gender = gender;
      weightModel.weight = weight;
      weightModel.sleepTime = sleepTime.format(context).toString();
      weightModel.wakeTime = wakeTime.format(context).toString();
      weightModel.waterIntakeGoal = ((weight * 0.033) * 1000).toInt();

      await firebaseFirestore
          .collection('user')
          .doc(user?.uid)
          .collection('user-info')
          .doc()
          .set(weightModel.toMap());
      Fluttertoast.showToast(msg: "Data Added Successfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShifterScreen()));
    } catch (e) {
      log(e.toString());
      setState(() {
        errorMessage = true;
      });
      print(e);
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffe9f8fb),
              Color(0xff65cee6),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              controller: pageController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
                    ),
                    SizedBox(height: 100),
                    Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value.toString();
                            });
                            log(value.toString());
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Male",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Female',
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value.toString();
                              log(value.toString());
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Female",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          pageController.nextPage(
                              duration: Duration(seconds: 2),
                              curve: Curves.fastOutSlowIn);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "WEIGHT",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
                    ),
                    SizedBox(height: 100),
                    Form(
                      key: _weightFormKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
                          }
                          if (int.parse(value) < 10) {
                            return "Please enter a valid weight";
                          }
                          return null;
                        },
                        cursorColor: Colors.purple,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: weightController,
                        decoration: textFieldDecoration.copyWith(
                          suffix: Text(
                            "KG",
                            style: TextStyle(color: Colors.black),
                          ),
                          label: Text("Weight"),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () {
                              pageController.previousPage(
                                  duration: Duration(seconds: 2),
                                  curve: Curves.fastLinearToSlowEaseIn);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            minWidth: 135.0,
                            height: 42.0,
                            child: Text(
                              'Previous',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Material(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () {
                              if (_weightFormKey.currentState!.validate()) {
                                pageController.nextPage(
                                    duration: Duration(seconds: 2),
                                    curve: Curves.fastLinearToSlowEaseIn);
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            },
                            minWidth: 135.0,
                            height: 42.0,
                            child: Text(
                              'Next',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Form(
                  key: finalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Visibility(
                        visible: timeError,
                        child: Text(
                          "Sleep and wake time can not be same",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Sleep Time"),
                      TextFormField(
                        validator: (value) {
                          if (value == "--:-- --") {
                            return "Please select a time";
                          }
                          return null;
                        },
                        controller: sleepTimeController,
                        cursorColor: Colors.purple,
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                        decoration: textFieldDecoration.copyWith(
                          suffixIcon: IconButton(
                              onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(
                                    context: context, initialTime: sleepTime);
                                if (newTime == null) return;
                                setState(() {
                                  sleepTime = newTime;
                                  sleepTimeController.text =
                                      newTime.format(context).toString();
                                });
                              },
                              icon: Icon(Icons.timer)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Wake Up Time"),
                      TextFormField(
                        validator: (value) {
                          if (value == "--:-- --") {
                            return "Please select a time";
                          }
                          return null;
                        },
                        cursorColor: Colors.purple,
                        controller: wakeTimeController,
                        readOnly: true,
                        textInputAction: TextInputAction.done,
                        decoration: textFieldDecoration.copyWith(
                          suffixIcon: IconButton(
                              onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(
                                    context: context, initialTime: wakeTime);
                                if (newTime == null) return;
                                setState(() {
                                  wakeTime = newTime;
                                  wakeTimeController.text =
                                      newTime.format(context).toString();
                                });
                              },
                              icon: Icon(Icons.timer)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Material(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            if (finalKey.currentState!.validate()) {
                              if (TimeConverter(sleepTime)
                                  .isAtSameMomentAs(TimeConverter(wakeTime))) {
                                setState(() {
                                  timeError = true;
                                });
                              } else {
                                postUserDetailsToFireStore(
                                    radioValue,
                                    int.parse(weightController.text),
                                    sleepTime,
                                    wakeTime);

                                setState(() {
                                  timeError = false;
                                });
                              }
                            }
                          },
                          minWidth: 135.0,
                          height: 42.0,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'Done',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
