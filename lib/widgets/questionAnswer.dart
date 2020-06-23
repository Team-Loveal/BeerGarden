import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget questionAnswer(String title, String body) {
  Color fontColor;
  FontWeight fontWeight;

  if (body == "fill it out!" || body == "Ask me!") {
    fontColor = Hexcolor("#8CC63E");
    fontWeight = FontWeight.bold;
  } else {
    fontColor = Colors.black;
    fontWeight = FontWeight.normal;
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 5),
          Text(body,
              style: TextStyle(
                  fontSize: 16.0, color: fontColor, fontWeight: fontWeight))
        ]),
  );
}
