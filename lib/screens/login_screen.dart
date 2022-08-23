import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:water_reminder/models/constants.dart';
import 'package:water_reminder/screens/register_screen.dart';
import 'package:water_reminder/screens/screen_shifter.dart';
import '../on-boarding/on_boarding_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool passwordVisible = true;
  bool isLoginError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffe9f8fb),
            Color(0xff65cee6),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: showSpinner
            ? SpinKitRipple(
                size: 100,
                color: Colors.lightBlue,
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            heightFactor: 3,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isLoginError,
                            child: Text(
                              "Please check your email or password",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Field required";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                            cursorColor: Colors.lightBlue,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: textFieldDecoration.copyWith(
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.lightBlue,
                              ),
                              label: Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          TextFormField(
                            validator: (value) {
                              RegExp regex = RegExp(r"^.{8,}$");
                              if (value!.isEmpty) {
                                return "Field is required";
                              }
                              if (!regex.hasMatch(value)) {
                                return "Password must contain 8 characters minimum";
                              }
                              return null;
                            },
                            cursorColor: Colors.purple,
                            textInputAction: TextInputAction.done,
                            obscureText: passwordVisible,
                            controller: passController,
                            decoration: textFieldDecoration.copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                              icon: Icon(
                                Icons.password_outlined,
                                color: Colors.lightBlue,
                              ),
                              label: Text(
                                "Password",
                                style: TextStyle(
                                    color: Colors.lightBlue, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              color: Colors.lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              elevation: 5.0,
                              child: MaterialButton(
                                onPressed: () {
                                  singIn(emailController.text,
                                      passController.text);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                minWidth: 200.0,
                                height: 42.0,
                                child: Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Don\'t have an account? '),
                              TextButton(
                                style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen()));
                                },
                                child: Text("SignUp"),
                              ),
                            ],
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

  void singIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          showSpinner = true;
        });
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) {
          setState(() {
            showSpinner = false;
          });
          setState(() {
            isLoginError = false;
          });
          validate();
          Fluttertoast.showToast(msg: "Login Successful");
        });
      } catch (e) {
        sleep(Duration(seconds: 5));
        showSpinner = false;
        setState(() {
          isLoginError = true;
        });
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      setState(() {
        isLoginError = true;
      });
      showSpinner = false;
    }
  }

  void validate() async {
    bool dataPresent = false;
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('user-info')
        .snapshots()
        .first
        .then((value) {
      dataPresent = value.docs.isEmpty;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => user == null
            ? LoginScreen()
            : dataPresent
                ? OnBoardingScreen()
                : ShifterScreen(),
      ),
    );
  }
}
