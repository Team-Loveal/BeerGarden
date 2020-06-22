import 'dart:ui';
import 'package:flutter/material.dart';

Widget fullScreenImage(
    BuildContext context, String src, double sigmaX, sigmaY) {
  return GestureDetector(
    child: Center(
      child: Hero(
        tag: 'imageHero',
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(src), fit: BoxFit.fitWidth)),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: Container(color: Colors.black.withOpacity(0))),
        ),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
}
