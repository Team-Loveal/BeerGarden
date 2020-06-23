import 'dart:ui';
import 'package:flutter/material.dart';

Widget fullScreenImage(
    BuildContext context, String src, double sigmaX, sigmaY) {
  return GestureDetector(
    child: Center(
        child: Stack(
          children: <Widget>[
        Image(image: NetworkImage(src)),
            Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                  child: Container(color: Colors.black.withOpacity(0))),
            ),
          ],
        ),

    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
}
