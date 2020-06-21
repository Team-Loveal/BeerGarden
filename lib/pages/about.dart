import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:ui';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
            stops: [0.2, 0.7],
          ),
        ),
        child: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Center(
              child: Wrap(
                children: <Widget>[
                  Text("About BeerGarden",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "BeerGarden is a new way to meet people and develop relationships in fun, beer themed environment. When you first sign up, you will be guided through our profile creation page, where you will be able to upload or take a profile photo for yourself. However, other users view your picture, or you view other people's pictures, the pictures will appear blurred. Don't panic! Your phone isn't dying and there are no mistakes with the image. At BeerGarden, we intentionally made peoples photos blurry to help develop relationships based on things like conversation, personality, and (digital) BEERS! Somewhat inspired by the idea of beer goggles, the more you drink, the better a person may look to you; in BeerGarden as you continue to communicate, build your relationships and 'drink' with other users, their profile picture will gradually become clearer to you, and yours will become more clear to them as well. At BeerGarden, we hope that users will be able to build stronger relationships by having genuine conversations instead of instantly judging people only based on their image. Please enjoy the BeerGarden, and grow your relationships over a beer!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}

//class About extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Container(
//            height: double.infinity,
//            width: double.infinity,
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                begin: Alignment.topCenter,
//                end: Alignment.bottomCenter,
//                colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
//                stops: [0.2, 0.7],
//              ),
//            ),
//            child: ListView(
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                  child: Wrap(
//                    children: <Widget>[
//                      Text("About BeerGarden",
//                          style: TextStyle(
//                            fontSize: 40,
//                            fontWeight: FontWeight.bold,
//                          )),
//                      Text(
//                        "BeerGarden is a new way to meet people and develop relationships in fun, beer themed environment. When you first sign up, you will be guided through our profile creation page, where you will be able to upload or take a profile photo for yourself. However, other users view your picture, or you view other people's pictures, the pictures will appear blurred. Don't panic! Your phone isn't dying and there are no mistakes with the image. At BeerGarden, we intentionally made peoples photos blurry to help develop relationships based on things like conversation, personality, and (digital) BEERS! Somewhat inspired by the idea of beer goggles, the more you drink, the better a person may look to you; in BeerGarden as you continue to communicate, build your relationships and 'drink' with other users, their profile picture will gradually become clearer to you, and yours will become more clear to them as well. At BeerGarden, we hope that users will be able to build stronger relationships by having genuine conversations instead of instantly judging people only based on their image. Please enjoy the BeerGarden, and grow your relationships over a beer!",
//                        style: TextStyle(
//                          fontSize: 25,
//                        ),)
//                    ],
//                  ),
//                )
//              ],
//            )));
//  }
//}
