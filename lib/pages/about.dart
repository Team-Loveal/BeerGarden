import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final pageList = [
    PageModel(
        color: Hexcolor("#F4AA33"),
        heroAssetPath: 'images/cheers.gif',
        title: Text("BeerGarden",
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontFamily: 'NTR',
            )),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(
              'Is a new way to meet people and develop relationships in fun, beer themed environment. Users will be able to get one match a day, and decide based on the matches profile whether they wish to start a conversation or not.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/cheers.gif'),
    PageModel(
        color: Hexcolor("#F4AA33"),
        heroAssetPath: 'images/getamatch.png',
        title: Text("When you first sign up",
            style: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontFamily: 'NTR',
            )),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(
              "You will be guided through our profile creation page, where you will be able to upload or take a profile photo for yourself. However, when other users view your picture, or you view other people's pictures, the pictures will appear blurred.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
        ),
        iconAssetPath: 'images/cheers.gif'),
    PageModel(
      color: Hexcolor("#F4AA33"),
      heroAssetPath: 'images/40%blur.png',
      title: Text("Don't panic!",
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontFamily: 'NTR',
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(
            "Your phone isn't dying! At BeerGarden, we intentionally make photos blurry to help develop more meaningful relationships based on things like conversation, personality, and (digital) BEERS! Inspired by the idea of beer goggles; the more you drink, the better a person may look to you. In BeerGarden as you continue to communicate and 'drink' with other users, their profile picture will gradually become clearer to you, and yours to them.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
      ),
      iconAssetPath: 'images/cheers.gif',
    ),
    PageModel(
      color: Hexcolor("#F4AA33"),
      heroAssetPath: 'images/0blur.png',
      title: Text("After conversation",
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.none,
            fontFamily: 'NTR',
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(
            "and time both users profile pictures will become 100% visible. At BeerGarden, we hope that users will be able to build stronger relationships by having genuine conversations opposed to instantly judging people only based on their image. Please enjoy the BeerGarden, and grow your relationships over a beer!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
      ),
      iconAssetPath: 'images/cheers.gif',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed('/'),
      ),
    );
  }
}
