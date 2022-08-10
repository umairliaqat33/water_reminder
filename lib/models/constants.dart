import 'package:flutter/material.dart';

const textFieldDecoration = InputDecoration(
  icon: null,
  label: null,
  // fillColor: Colors.white,
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
