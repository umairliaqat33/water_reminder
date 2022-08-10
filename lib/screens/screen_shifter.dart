import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/screens/home_screen.dart';
import 'package:water_reminder/screens/login_screen.dart';
import 'package:water_reminder/screens/settings_screen.dart';

class ShifterScreen extends StatefulWidget {
  @override
  State<ShifterScreen> createState() => _ShifterScreenState();
}

class _ShifterScreenState extends State<ShifterScreen> {
  int index = 0;
  final screens = [HomeScreen(), SettingsScreen()];

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
            color: Color(0xff65cee6),
          ),
          title: Text("Water Reminder"),
          actions: [
            IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff65cee6),
            selectedItemColor: Colors.white,
            currentIndex: index,
            onTap: (i) {
              setState(() {
                index = i;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings_outlined),
              ),
            ]),
        body: screens[index],
      ),
    );
  }
}
