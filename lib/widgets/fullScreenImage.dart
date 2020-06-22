import 'dart:ui';
import 'package:flutter/material.dart';

Widget fullScreenImage(
    BuildContext context, String src, double sigmaX, sigmaY) {
  return GestureDetector(
    child: Center(
      child: Hero(
        tag: 'imageHero',
        child: Stack(
          children: <Widget>[
            Image(image: NetworkImage(src)),
            Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(color: Colors.black.withOpacity(0))),
            ),
          ],
        ),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
}
