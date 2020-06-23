import 'dart:ui';
import 'package:flutter/material.dart';

Widget fullScreenImage(
    BuildContext context, String src, double sigmaX, sigmaY) {
  return GestureDetector(
    child: Center(
      child: Container(
        //padding: EdgeInsets.all(10),
        //alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //tag: 'imageHero',
        child: Stack(
          children: <Widget>[
            Image(image: NetworkImage(src)),
            Positioned.fill(
                //Container(
                //width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                  child: Container(color: Colors.black.withOpacity(0))),
            )),
            //),
          ],
        ),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
    },
  );
}
