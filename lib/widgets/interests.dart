import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget interests(String interest) {
  return Container(
      margin: EdgeInsets.only(right: 10),
      child: OutlineButton(
          child: Text(interest, style: TextStyle(color: Hexcolor("#8CC63E"))),
          onPressed: null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0))));
}
