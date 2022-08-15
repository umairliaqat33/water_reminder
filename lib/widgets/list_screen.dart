import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ListScreenWidget extends StatefulWidget {
  const ListScreenWidget({Key? key}) : super(key: key);

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget> {
  User? user;

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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                Text("$formattedTime"),
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
}
