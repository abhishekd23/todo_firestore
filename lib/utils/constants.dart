import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  fillColor: Colors.black,
  hintStyle: TextStyle(
    fontSize: 15,
    //fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffffab41), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xffffab41), width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);

const Color backgroundColor = const Color(0xffffab41);
