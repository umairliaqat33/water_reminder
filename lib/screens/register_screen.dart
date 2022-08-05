import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(colors: [
        //     Color(0xffe9f8fb),
        //     Color(0xff65cee6),
        //   ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter
        //   ),
        // ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
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
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_outline,
                            color: Colors.lightBlue,
                          ),
                          label: Text(
                            "Name",
                            style: TextStyle(color: Colors.lightBlue, fontSize: 20),
                          ),
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
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
                            return "Field required";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Colors.lightBlue,
                          ),
                          label: Text(
                            "Email",
                            style: TextStyle(color: Colors.lightBlue, fontSize: 20),
                          ),
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
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
                        decoration: InputDecoration(
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
                            style: TextStyle(color: Colors.lightBlue, fontSize: 20),
                          ),
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
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
                        decoration:InputDecoration(
                          icon: Icon(
                            Icons.password,
                            color: Colors.lightBlue,
                          ),
                          label: Text(
                            "Confirm Password",
                            style: TextStyle(color: Colors.lightBlue, fontSize: 20),
                          ),
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        )
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () {
                              SignUp(
                                  userNameController.text, passController.text);
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
                              Navigator.push(
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
      ),
    );
  }

  void SignUp(String email, String password) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          showSpinner = true;
        });
        sleep(const Duration(seconds: 5));
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          // postDetailsToFireStore();
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
          showSpinner = false;
        });
        sleep(const Duration(seconds: 5));
        setState(() {
          isLoginError = true;
        });
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      setState(() {
        isLoginError = true;
      });
    }
  }

  // postDetailsToFireStore() async {
  //   try {
  //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //     User? user = _auth.currentUser;
  //     CredentialUserModel credentialUserModel = CredentialUserModel();
  //     credentialUserModel.userName = name_Controller.text;
  //     credentialUserModel.email = user!.email;
  //     credentialUserModel.id = user.uid;
  //     await firebaseFirestore
  //         .collection('Users')
  //         .doc(user.uid)
  //         .set(credentialUserModel.toMap());
  //
  //     Fluttertoast.showToast(msg: "Account Created Successfully");
  //     // Navigator.pushReplacement(context,
  //     //     MaterialPageRoute(builder: (context) => WelcomeUserScreen()));
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

}