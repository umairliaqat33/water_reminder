import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/models/constants.dart';
import 'package:water_reminder/models/data_model.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  User? user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String? radioValue;
  final weightController = TextEditingController();
  final wakeTimeController = TextEditingController();
  final sleepTimeController = TextEditingController();
  TimeOfDay sleepTime = TimeOfDay.now();
  TimeOfDay wakeTime = TimeOfDay.now();
  String? id;

  void update(String gender, int weight, TimeOfDay sleepTime,
      TimeOfDay wakeTime, BuildContext context) async {
    WeightModel weightModel = WeightModel();
    weightModel.gender = gender;
    weightModel.weight = weight;
    weightModel.sleepTime = sleepTime.format(context).toString();
    weightModel.wakeTime = wakeTime.format(context).toString();

    await firebaseFirestore
        .collection('user')
        .doc(user!.uid)
        .collection('user-info')
        .doc(id)
        .update(weightModel.toMap());
    Fluttertoast.showToast(msg: "Data Updated");
  }

  getData() async {
    try {
      await firebaseFirestore
          .collection('user')
          .doc(user!.uid)
          .collection('user-info')
          .snapshots()
          .listen((event) {
        event.docs.forEach((data) {
          setState(() {
            radioValue = data.get('gender');
            final format = DateFormat.jm();
            sleepTime =
                TimeOfDay.fromDateTime(format.parse(data.get('sleeptime')));
            id = data.id;
            wakeTime =
                TimeOfDay.fromDateTime(format.parse(data.get('waketime')));
            wakeTimeController.text = wakeTime.format(context).toString();
            sleepTimeController.text = sleepTime.format(context).toString();
            weightController.text = data.get("weight").toString();
          });
        });
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
    return Scaffold(
      backgroundColor: Color(0xffC6DFE8),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gender",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value.toString();
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
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
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Female",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Weight",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        if (value == "0") {
                          return "Weight can not be 0";
                        }
                        if (value == "1") {
                          return "Weight can not be 1";
                        }
                        return null;
                      },
                      cursorColor: Colors.purple,
                      textInputAction: TextInputAction.done,
                      controller: weightController,
                      decoration: textFieldDecoration.copyWith(
                        suffix: Text(
                          "KG",
                          style: TextStyle(color: Colors.black),
                        ),
                        label: Text(
                          "Weight",
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sleep Time",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      controller: sleepTimeController,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Wake Up Time",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
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
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            update(radioValue!, int.parse(weightController.text),
                                sleepTime, wakeTime, context);
                          }
                        },
                        minWidth: 135.0,
                        height: 42.0,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.update,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
