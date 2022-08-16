import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/on-boarding/on_boarding_screen.dart';
import 'package:water_reminder/screens/screen_shifter.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user;
  bool dataPresent = false;
  String? uid;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
    // dataPresent = FirebaseFirestore.instance
    //     .collection('user')
    //     .doc(uid)
    //     .collection('user-info')
    //     .doc()
    //     .id;
    //     .snapshots()
    //     .isEmpty
    //     .then((value) {
    //   dataPresent = value.toString();
    // });
    FirebaseFirestore.instance.collection('user').doc(uid).collection('user-info').snapshots().first.then((value){
      dataPresent=value.docs.isEmpty;
    });
    _navigator();
    super.initState();
  }

  _navigator() {
    Timer(Duration(milliseconds: 10005), () {
      log("Going to Switch");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => user == null
                  ? LoginScreen()
                  : dataPresent
                      ? OnBoardingScreen()
                      : ShifterScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbcebf5),
      body: Center(
        child: TextLiquidFill(
          text: 'Water Reminder',
          loadDuration: Duration(milliseconds: 10000),
          waveDuration: Duration(milliseconds: 1000),
          waveColor: Colors.lightBlueAccent,
          boxBackgroundColor: Color(0xffbcebf5),
          textStyle: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
