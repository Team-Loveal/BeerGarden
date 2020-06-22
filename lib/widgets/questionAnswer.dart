import 'dart:ui';
import 'package:flutter/material.dart';

Widget questionAnswer(String title, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 5),
          Text(body, style: TextStyle(fontSize: 16.0))
        ]),
  );
}
