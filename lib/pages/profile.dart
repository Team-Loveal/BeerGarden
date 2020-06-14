import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/auth.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:lovealapp/services/database.dart';

class MyProfile extends StatefulWidget {
  // final String userID;
  // final String nickname;

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);

    return StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              body: ListView(
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
                            await _auth.signOut();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            size: 35,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.of(context).pushNamed('/editProfile');
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
                                Text('${userData.nickname}, ${userData.age}',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)),
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
                        Expanded(
                          child: CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(userData.imgUrl)),
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
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.shopping)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Shopping",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.makingBalloonAnimals)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("MakingBalloonAnimals",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.cooking)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Cooking",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.painting)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Painting",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.movies)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Movies",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.sports)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Sports",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.writing)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Writing",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                              if (userData.drinking)
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: OutlineButton(
                                        child: Text("Drinking",
                                            style:
                                                TextStyle(color: Colors.pink)),
                                        onPressed: null,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)))),
                            ],
                          )
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 80),
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
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
