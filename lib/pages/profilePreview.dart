//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/match.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class ProfilePreview extends StatefulWidget {
  final File profileImg;

  ProfilePreview({Key key, @required this.profileImg}) : super(key: key);

  @override
  _ProfilePreviewState createState() => _ProfilePreviewState(profileImg);
}

class _ProfilePreviewState extends State<ProfilePreview> {
  final File profileImg;

  _ProfilePreviewState(this.profileImg);

  @override
  Widget build(BuildContext context) {
    //get userData from the DB
    final user = Provider.of<User>(context);


    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          //snapshot is data coming down the stream
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  //get potential matches for the user
                  Firestore.instance
                      .collection("users")
                      .getDocuments()
                      .then((querySnapshot) {
                    querySnapshot.documents.forEach((document) {
                      if (document.documentID != user.uid) {
                        //concat and make into a string and push into chatIds array
                        String toID = document.documentID;
                        String chatId1 = '${user.uid} - ${document.documentID}';
                        String chatId2 = '${document.documentID} - ${user.uid}';

                        //check messages documents , if it doesn't exist write to the db
                        Firestore.instance
                            .collection("messages")
                            .getDocuments()
                            .then((querySnapshot) {
                          querySnapshot.documents.forEach((document) {
                            if (chatId1 != document.documentID &&
                                chatId2 != document.documentID) {
                              //can you create a document without creating a field?
                              Firestore.instance
                                  .collection("messages")
                                  .document(chatId1)
                                  .setData({
                                'fromID': user.uid,
                                'toID': toID,
                                'chatted': false,
                              });
                            }
                          });
                        });
                      }
                    });
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationHome()),
                  );
                },
                isExtended: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                icon: Icon(Icons.check),
                label: Text('CONFIRM'),
                backgroundColor: Colors.pink,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: ListView(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text('Profile',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ))),
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
                                    Text('Tokyo, Japan',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey))
                                  ],
                                ),
                              ]),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(profileImg),
                          ),
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
                          Text(userData.occupation,
                              style: TextStyle(fontSize: 16))
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
