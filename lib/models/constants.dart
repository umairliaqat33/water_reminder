import 'package:flutter/material.dart';

const textFieldDecoration = InputDecoration(
  icon: null,
  label: null,
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 10,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
);

DateTime TimeConverter(TimeOfDay time){
  return DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,time.hour,time.minute);
}