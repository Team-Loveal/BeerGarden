import 'dart:ui';
import 'package:flutter/material.dart';

Widget fullScreenImage(BuildContext context, String src) {
  return GestureDetector(
    child: Center(
      child: Hero(
        tag: 'imageHero',
        child: Image.network(
          src,
        ),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
}
