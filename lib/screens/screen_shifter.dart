import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water_reminder/screens/home_screen.dart';
import 'package:water_reminder/screens/login_screen.dart';
import 'package:water_reminder/screens/settings_screen.dart';

class ShifterScreen extends StatefulWidget {
  @override
  State<ShifterScreen> createState() => _ShifterScreenState();
}

class _ShifterScreenState extends State<ShifterScreen> {
  int index = 0;
  List<dynamic> screens = [HomeScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            color: Color(0xff4FA8C5),
          ),
          title: Center(child: Text(index == 0 ? "Home" : "Settings")),
          actions: [
            IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                Fluttertoast.showToast(msg: "Logout Successful");
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff4FA8C5),
            selectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(
              size: 40,
            ),
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
