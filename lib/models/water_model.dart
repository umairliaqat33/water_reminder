import 'package:cloud_firestore/cloud_firestore.dart';

class WaterModel {
  Timestamp? time;
  int? millLiters;

  WaterModel({this.time, this.millLiters});

  factory WaterModel.fromMap(map) {
    return WaterModel(time: map['time'], millLiters: map['millLiters']);
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'millLiters': millLiters,
    };
  }
}
