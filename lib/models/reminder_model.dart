import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  Timestamp? timestamp;
  bool? onOff;

  ReminderModel({this.timestamp, this.onOff});

  Map<String, dynamic> toMap() {
    return {'time': timestamp, 'onOff': onOff};
  }

  factory ReminderModel.fromMap(map) {
    return ReminderModel(timestamp: map['time'], onOff: map['onOff']);
  }
}
