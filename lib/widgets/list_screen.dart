import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:water_reminder/models/water_model.dart';
import 'package:water_reminder/widgets/delete_alert_dialogue.dart';

class ListScreenWidget extends StatefulWidget {
  const ListScreenWidget({Key? key}) : super(key: key);

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  User? user;
  TimeOfDay time = TimeOfDay.now();

  delete(String id) {}

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(user?.uid)
            .collection('water-model')
            .orderBy('time')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data!.docs.length,
                    itemBuilder: (context, index) {
                      Timestamp t = data.docs[index].get('time');
                      DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                          t.microsecondsSinceEpoch);
                      String formattedTime = DateFormat.jm().format(date);
                      return Container(
                        height: 60,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.glassWater,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                        "${data.docs[index].get('millLiters')} ml"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("$formattedTime"),
                                    PopupMenuButton(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              deleteAlertDialogue(
                                                  context,
                                                  data.docs[index].id,
                                                  user!.uid);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: TextButton(
                                            style: ButtonStyle(
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                            ),
                                            onPressed: () async {
                                              TimeOfDay? newTime =
                                                  await showTimePicker(
                                                      context: context,
                                                      initialTime: time);
                                              if (newTime == null) return;
                                              setState(() {
                                                time = newTime;
                                              });
                                              update(time, data.docs[index].id);

                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          );
        });
  }

  update(TimeOfDay timeOfDay, String id) {
    DateTime d = DateTime.now();
    DateTime dateTime =
        DateTime(d.year, d.month, d.day, timeOfDay.hour, timeOfDay.minute);
    WaterModel waterModel = WaterModel();
    waterModel.millLiters = 100;
    waterModel.time = Timestamp.fromDate(dateTime);
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('water-model')
        .doc(id)
        .update(waterModel.toMap());
    Fluttertoast.showToast(msg: "Record Updated");
  }
}
