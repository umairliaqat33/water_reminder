import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

deleteAlertDialogue(BuildContext context, String id, String uid) {
  return showDialog(
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          title: Text("Delete water record"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Are you sure you want to delete?",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "*Once deleted can not be restored again*",
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                try {
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(uid)
                      .collection('water-model')
                      .doc(id)
                      .delete();
                  Fluttertoast.showToast(msg: "Water record deleted");
                } catch (e) {
                  print(e);
                  Fluttertoast.showToast(msg: e.toString());
                }
                Navigator.of(context).pop();
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
      context: context);
}
