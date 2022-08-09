import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:water_reminder/models/constants.dart';
import 'package:water_reminder/screens/screen_shifter.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final weightController = TextEditingController();
  final pageController = PageController();
  String radioValue = "Male";
  TimeOfDay time = TimeOfDay.now();
  final sleepTimeController = TextEditingController(text: "9:00 PM");
  final wakeTimeController = TextEditingController(text: "9:00 AM");
  final _weightFormKey = GlobalKey<FormState>();

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
                    SizedBox(
                      height: 100,
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
                            log(value.toString());
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
                              log(value.toString());
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
                Form(
                  key: _weightFormKey,
                  child: Column(
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
                      SizedBox(
                        height: 100,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field is required";
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
                          label: Text("Weight"),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
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
                          SizedBox(
                            width: 10,
                          ),
                          Material(
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
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
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Sleep Time"),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      cursorColor: Colors.purple,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      controller: sleepTimeController,
                      decoration: textFieldDecoration.copyWith(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: time);
                              if (newTime == null) return;
                              setState(() {
                                time = newTime;
                                sleepTimeController.text = time.format(context);
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
                        if (value!.isEmpty) {
                          return "Field is required";
                        }
                        return null;
                      },
                      cursorColor: Colors.purple,
                      readOnly: true,
                      textInputAction: TextInputAction.done,
                      controller: wakeTimeController,
                      decoration: textFieldDecoration.copyWith(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: time);
                              if (newTime == null) return;
                              setState(() {
                                wakeTimeController.text =
                                    newTime.format(context);
                              });
                            },
                            icon: Icon(Icons.timer)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShifterScreen()));
                          FocusManager.instance.primaryFocus?.unfocus();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
