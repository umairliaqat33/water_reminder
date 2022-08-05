import 'dart:async';
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
    _navigator();
    super.initState();
  }

  _navigator() {
    Timer(Duration(milliseconds:10005), () {
      log("Going to Switch");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
            fontSize: 55,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
