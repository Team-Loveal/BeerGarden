import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:hexcolor/hexcolor.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  double sigmaX = 0;
  double sigmaY = 0;

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userData = Provider.of<UserData>(context);
    if (userData != null) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
            stops: [0.2, 0.7],
          )),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text("logout"),
                      onPressed: () async {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        await _auth.signOut();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        Icons.settings,
                        size: 35,
                        color: Colors.orange,
                      ),
                      onPressed: () async {
                        Navigator.pushReplacementNamed(context, '/editProfile',
                            arguments: {
                              'nicknameEdit': userData.nickname,
                              'locationEdit': userData.location,
                              'occupationEdit': userData.occupation,
                              'aboutEdit': userData.about,
                              'ageEdit': userData.age,
                              'genderEdit': userData.gender,
                              'yodelingEdit': userData.yodeling,
                              'shoppingEdit': userData.shopping,
                              'makingBalloonAnimalsEdit':
                                  userData.makingBalloonAnimals,
                              'cookingEdit': userData.cooking,
                              'paintingEdit': userData.painting,
                              'moviesEdit': userData.movies,
                              'sportsEdit': userData.sports,
                              'writingEdit': userData.writing,
                              'drinkingEdit': userData.drinking,
                            });
                      },
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  '${userData.nickname}, ${userData.age.toString()}',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(MdiIcons.mapMarker,
                                    size: 18, color: Colors.grey),
                                Text('${userData.location}, Japan',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey))
                              ],
                            ),
                          ]),
                    ),
                    //IMAGE
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                width: 380,
                height: 380,
                child: Stack(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 380,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(userData.imgUrl,
                                  fit: BoxFit.cover),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 380,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: sigmaX, sigmaY: sigmaY),
                                  child: Container(
                                      color: Colors.black.withOpacity(0))),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Occupation',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Expanded(
                          child: Text(userData.occupation,
                              style: TextStyle(fontSize: 16)))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Interests',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Wrap(
                        children: <Widget>[
                          //WHEN REFACTORING CREATE SEPARATE WIDGET AND MAP THROUGH INTERESTS
                          if (userData.yodeling)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Yodeling",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.shopping)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Shopping",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.makingBalloonAnimals)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("MakingBalloonAnimals",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.cooking)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Cooking",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.painting)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Painting",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.movies)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Movies",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.sports)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Sports",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.writing)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Writing",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                          if (userData.drinking)
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                child: OutlineButton(
                                    child: Text("Drinking",
                                        style: TextStyle(color: Colors.pink)),
                                    onPressed: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                        ],
                      )
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('About me',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.about, style: TextStyle(fontSize: 16))
                    ]),
              ),
              //ANSWERS
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Wrap(children: <Widget>[
                  Text('🛌 Do you make your bed in the morning?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(userData.bed ?? "fill it out!",
                      style: TextStyle(fontSize: 16)),
                ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Wrap(children: <Widget>[
                  Text('🤓 Do you read reviews, or just go with your gut?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(userData.reviews ?? "fill it out!",
                      style: TextStyle(fontSize: 16)),
                ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Wrap(children: <Widget>[
                  Text(
                      '🌮 If you could only eat one thing for the rest of your life, what would it be?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(userData.foreverEat ?? "fill it out!",
                      style: TextStyle(fontSize: 16)),
                ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Wrap(children: <Widget>[
                  Text(
                      "🌭 If you're eating a meal do you save the best thing for last or eat it first?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 5),
                  Text(userData.bestForLast ?? "fill it out!",
                      style: TextStyle(fontSize: 16)),
                ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('👽 Do you believe in aliens?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.aliens ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '🚽 If you were a piece of furniture, what piece of furniture would you be?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.furniture ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'Would you rather have a home in the beach or the mountains?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.beachOrMountain ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '🍱 When you get take-out food do you eat out of the container or transfer the food to dishes?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.takeOutFood ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '🏝 If you were deserted on an island what items would you bring with you?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.desertedIsland ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          '💒 If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.wedding ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('🏡 Your place or mine?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 5),
                      Text(userData.yourPlaceOrMine ?? "fill it out!",
                          style: TextStyle(fontSize: 16))
                    ]),
              ),
              //ANSWER MORE QUESTIONS BTN
              Container(
                margin: const EdgeInsets.fromLTRB(60, 10, 60, 40),
                child: ButtonTheme(
                  height: 40.0,
                  child: RaisedButton(
                      child: Text('Answer some more questions',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                      color: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () => {
                            Navigator.of(context)
                                .pushNamed('/moreQuestions', arguments: {
                              'furniture': userData.furniture,
                              'beachOrMountain': userData.beachOrMountain,
                              'takeOutFood': userData.takeOutFood,
                              'desertedIsland': userData.desertedIsland,
                              'wedding': userData.wedding,
                              'yourPlaceOrMine': userData.yourPlaceOrMine,
                              'bed': userData.bed,
                              'reviews': userData.reviews,
                              'foreverEat': userData.foreverEat,
                              'bestForLast': userData.bestForLast,
                              'aliens': userData.aliens
                            }),
                            //Navigator.of(context).pushNamed('/moreQuestions')
                          }),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
