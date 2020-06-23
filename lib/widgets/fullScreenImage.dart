import 'dart:ui';
import 'package:flutter/material.dart';

Widget fullScreenImage(
    BuildContext context, String src, double sigmaX, sigmaY) {
  return GestureDetector(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(src),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(color: Colors.black.withOpacity(0)),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
}
