import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text("About BeerGarden",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontFamily: 'NTR',
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "BeerGarden is a new way to meet people and develop relationships in fun, beer themed environment. Users will be able to get one match a day, and decide based on the matches profile whether they wish to start a conversation or not.",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontFamily: 'Alata',
                      ),
                    ),
                  ),
                  Image(image: AssetImage('images/getamatch.png')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "When you first sign up, you will be guided through our profile creation page, where you will be able to upload or take a profile photo for yourself. However, when other users view your picture, or you view other people's pictures, the pictures will appear blurred.",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontFamily: 'Alata',
                      ),
                    ),
                  ),
                  Image(image: AssetImage('images/bird.jpg')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Don't panic! Your phone isn't dying and there are no errors with the image. At BeerGarden, we intentionally made peoples photos blurry to help develop more meaningful relationships based on things like conversation, personality, and (digital) BEERS! Somewhat inspired by the idea of beer goggles, the more you drink, the better a person may look to you; in BeerGarden as you continue to communicate, build your relationships and 'drink' with other users, their profile picture will gradually become clearer to you, and yours to them as well.",
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: 'Alata',
                      ),
                    ),
                  ),
                  Image(image: AssetImage('images/dinojeff.jpg')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "After some great conversation and time both users profile pictures will become 100% visible.",
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: 'Alata',
                      ),
                    ),
                  ),
                  Image(image: AssetImage('images/listen.jpg')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "At BeerGarden, we hope that users will be able to build stronger relationships by having genuine conversations opposed to instantly judging people only based on their image. Please enjoy the BeerGarden, and grow your relationships over a beer!",
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontFamily: 'Alata',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/login')},
                        minWidth: 250),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: MaterialButton(
                        child: Text('Signup',
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/signup')},
                        minWidth: 250),
                  ),
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
