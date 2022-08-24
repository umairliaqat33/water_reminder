import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:water_reminder/models/constants.dart';
import 'package:water_reminder/models/user_model.dart';
import 'package:water_reminder/on-boarding/on_boarding_screen.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final userNameController = TextEditingController();
  final passController = TextEditingController();
  final C_pass_controller = TextEditingController();
  final name_Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  bool isLoginError = false;
  String errorMessage = "Something Went Wrong Please Try again";
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbcebf5),
      body: showSpinner
          ? SpinKitRipple(
              size: 100,
              color: Colors.lightBlue,
            )
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          heightFactor: 2,
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isLoginError,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.purpleAccent,
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.black),
                          controller: name_Controller,
                          decoration: textFieldDecoration.copyWith(
                            label: Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 20),
                            ),
                            icon: Icon(
                              Icons.person_outline,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
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
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.purple,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black),
                          controller: userNameController,
                          decoration: textFieldDecoration.copyWith(
                            label: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 20),
                            ),
                            icon: Icon(
                              Icons.email_outlined,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            RegExp regex = new RegExp(r"^.{8,}$");
                            if (value!.isEmpty) {
                              return "Field is required";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Password must contain 8 characters minimum";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.purple,
                          obscureText: _passwordVisible,
                          style: TextStyle(color: Colors.black),
                          controller: passController,
                          decoration: textFieldDecoration.copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.lightBlue,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            icon: Icon(
                              Icons.password,
                              color: Colors.lightBlue,
                            ),
                            label: Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Field is required";
                            }
                            if (value != passController.text) {
                              return "Password do not match try again";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.purple,
                          obscureText: _passwordVisible,
                          style: TextStyle(color: Colors.black),
                          controller: C_pass_controller,
                          decoration: textFieldDecoration.copyWith(
                            icon: Icon(
                              Icons.password,
                              color: Colors.lightBlue,
                            ),
                            label: Text(
                              "Confirm Password",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () {
                                SignUp(userNameController.text,
                                    passController.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              splashColor: null,
                              minWidth: 200.0,
                              height: 42.0,
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Already have an account? '),
                            TextButton(
                              style: ButtonStyle(
                                  splashFactory: NoSplash
                                      .splashFactory //removing onclick splash color
                                  ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text("LogIn"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void SignUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showSpinner = true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFireStore();
      }).catchError((e) {
        if (e.toString() ==
            "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
          setState(() {
            errorMessage = "Email already in use";
          });
        }
        setState(() {
          showSpinner = false;
        });
        setState(() {
          isLoginError = true;
        });
      });
    } else {
      setState(() {
        isLoginError = true;
      });
    }
  }

  postDetailsToFireStore() async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;
      UserModel userModel = UserModel();
      userModel.name = name_Controller.text;
      userModel.email = user!.email;
      userModel.id = user.uid;
      await firebaseFirestore
          .collection('user')
          .doc(user.uid)
          .set(userModel.toMap());

      Fluttertoast.showToast(msg: "Account Created Successfully");
      setState(() {
        showSpinner = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
