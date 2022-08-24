import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:water_reminder/screens/screen_shifter.dart';
import 'package:water_reminder/services/notification_logic.dart';
import 'package:water_reminder/widgets/reminder_delete_dialogue.dart';
import 'package:water_reminder/widgets/switch.dart';
import 'package:water_reminder/widgets/add_alert_dialogue.dart';

class ReminderScheduler extends StatefulWidget {
  final DateTime sleepTime;
  final DateTime wakeTime;

  ReminderScheduler(this.wakeTime, this.sleepTime);

  @override
  State<ReminderScheduler> createState() => _ReminderSchedulerState();
}

class _ReminderSchedulerState extends State<ReminderScheduler> {
  User? user;
  bool on = true;

  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    NotificationLogic.init(context,user!.uid);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationLogic.onNotifications.listen((value) {});
  }

  void onClickedNotification(String? payload) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShifterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Reminders"),
        backgroundColor: Color(0xff4FA8C5),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addAlertDialogue(
              context, widget.sleepTime, widget.wakeTime, user!.uid);
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(user!.uid)
              .collection('reminder')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4FA8C5)),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("Nothing to show"));
            }
            final data = snapshot.data;
            return ListView.builder(
                itemCount: data?.docs.length,
                itemBuilder: (context, index) {
                  Timestamp t = data?.docs[index].get('time');
                  DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                      t.microsecondsSinceEpoch);
                  String formattedTime = DateFormat.jm().format(date);
                  on = data!.docs[index].get('onOff');
                  if (on) {
                    NotificationLogic.showNotification(
                        dateTime: date,
                        id: 0,
                        title: 'Water Reminder',
                        body: "Don\'t forget to drink water");
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(
                              formattedTime,
                              style: TextStyle(fontSize: 30),
                            ),
                            subtitle: Text(
                              "Everyday",
                            ),
                            trailing: Container(
                              width: 110,
                              child: Row(
                                children: [
                                  Switcher(on, user!.uid, data.docs[index].id,
                                      data.docs[index].get('time')),
                                  IconButton(
                                      onPressed: () {
                                        reminderDeleteAlertDialogue(context,
                                            data.docs[index].id, user!.uid);
                                      },
                                      icon:
                                          FaIcon(FontAwesomeIcons.circleXmark))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
