
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_reminder/models/constants.dart';

import '../models/reminder_model.dart';

addAlertDialogue(
    BuildContext context, DateTime sleepTime, DateTime wakeTime, String uid) {
  TimeOfDay time = TimeOfDay.now();
  bool errorVisible = false;
  add(String uid, TimeOfDay time) {
    try {
      DateTime d = DateTime.now();
      DateTime dateTime =
          DateTime(d.year, d.month, d.day, time.hour, time.minute);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      ReminderModel reminderModel = ReminderModel();
      reminderModel.timestamp = timestamp;
      reminderModel.onOff = false;
      FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('reminder')
          .doc()
          .set(reminderModel.toMap());
      Fluttertoast.showToast(msg: "Reminder Added");
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              title: Text("Add reminder"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Select a Time for reminder"),
                    SizedBox(height: 20),
                    Visibility(
                      visible: errorVisible,
                      child: Text(
                        "Please select reminder after wake and before sleep time",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());

                        if (newTime == null) return;
                        setState(() {
                          time = newTime;
                        });
                      },
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: Colors.lightBlue,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            time.format(context).toString(),
                            style: TextStyle(
                                color: Colors.lightBlue, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if (TimeConverter(time).isBefore(sleepTime) ||
                          TimeConverter(time).isAfter(wakeTime)) {
                        add(uid, time);
                        Navigator.of(context).pop();
                        setState(() {
                          errorVisible = false;
                        });
                      } else {
                        setState(() {
                          errorVisible = true;
                        });
                      }
                    },
                    child: Text("Add")),
              ],
            );
          },
        );
      });
}
