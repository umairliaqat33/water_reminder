import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/screens/home_screen.dart';
import 'package:water_reminder/screens/login_screen.dart';
import 'package:water_reminder/screens/settings_screen.dart';

class ShifterScreen extends StatelessWidget {
  const ShifterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 20,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffe9f8fb),
                Color(0xff65cee6),
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
            ),
          ),
          title: Text("Water Reminder"),
          actions: [
            IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              icon: Icon(Icons.logout,color: Colors.lightBlue,),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorWeight: 5,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.white, width: 3),
            ),
            tabs: [
              Tab(
                text: "Home",
                icon: Icon(Icons.home),
              ),
              Tab(
                text: "Password Generator",
                icon: Icon(Icons.settings_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          HomeScreen(),
          SettingsScreen(),
        ]),
      ),
    );
  }
}
