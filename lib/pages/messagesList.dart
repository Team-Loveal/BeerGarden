import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'message.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  //for blur
  double sigmaX;
  double sigmaY;

  //RIKUS BLUR CODE - OK TO DELETE??
//  @override
//  void initState() {
//    super.initState();
//
//    decreaseBlur();
//  }

//  void decreaseBlur() async {
//    final user = Provider.of<User>(context);
//    // decrease blur everyday by 5
//    var querySnapshot = await Firestore.instance
//        .collection('messages')
//        .where('matchedUsers', arrayContains: user.uid)
//        .where('matched', isEqualTo: true)
//        .where('active', isEqualTo: true)
//        .getDocuments();
//
//    querySnapshot.documents.forEach((document) => {
//          Firestore.instance
//              .collection('messages')
//              .document(document.documentID)
//              .collection('chatroom')
//              .orderBy('timestamp', descending: false)
//              .limit(1)
//              .getDocuments()
//              .then((document) => {print(document.documents[0]['timestamp'])})
//
//          // print(timestamp);
//        });
//
//    getBlur();
//  }

  // calculates blur
//  void getBlur() {
//    // var now = new DateTime.now();
//  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
        backgroundColor: Hexcolor("#F4AA33"),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: AppBar(
            backgroundColor: Hexcolor("#F4AA33"),
            flexibleSpace: Container(
              child: Center(
                child: Text('Messages',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 48.0)),
              ),
            ),
            elevation: 0.0,
            automaticallyImplyLeading: false,
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('messages')
                                .where('matchedUsers', arrayContains: user.uid)
                                .where('matched', isEqualTo: true)
                                .where('active', isEqualTo: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Text("No messages..."),
                                );
                              } else {
                                return ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) =>
                                        _buildChatroom(
                                            snapshot.data.documents[index],
                                            context),
                                    itemCount: snapshot.data.documents.length,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildChatroom(DocumentSnapshot document, BuildContext context) {
    final user = Provider.of<User>(context);
    var matchID = document['matchedUsers'].firstWhere((id) => id != user.uid);
    var formatter = new DateFormat('MMMMd');
    bool unread = false;
    DateTime date;
    String nickname;
    String imgUrl;

// get blur values (not sure if this is the right place to put it
//        Firestore.instance.collection('messages').document(document.documentID).get().then((doc) {
//      setState(() {
//        sigmaX = doc['blur'].toDouble();
//        sigmaY = doc['blur'].toDouble();
//        print(doc['blur']);
//      });
//    });

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Message(
                    chatRoomID: document.documentID,
                    matchID: matchID,
                    nickname: nickname,
                    imgUrl: imgUrl)));
      },
      child: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection('users').document(matchID).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              margin: EdgeInsets.only(top: 5.0, right: 20.0, bottom: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .document(document.documentID)
                      .collection('chatroom')
                      .orderBy('timestamp', descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (context, messages) {
                    if (!messages.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      // Format timestamp to "Month Day"
                      date = new DateTime.fromMillisecondsSinceEpoch(
                          int.parse(messages.data.documents[0]['timestamp']));
                      unread =
                          messages.data.documents[0]['fromID'] != user.uid &&
                              messages.data.documents[0]['unread'];
                      nickname = snapshot.data['nickname'];
                      imgUrl = snapshot.data['imgUrl'];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: unread
                                        ? Hexcolor('#F4AA33')
                                        : Hexcolor('#f1f4f5'),
                                    radius: 38,
                                    child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(imgUrl)),
                                  ),
                                  Container(
                                      width: 75,
                                      height: 75,
                                      child: ClipOval(
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: sigmaX ?? 50, sigmaY: sigmaY ?? 50),
                                            child: Container(
                                                color:
                                                Colors.black.withOpacity(0))),
                                      )),
                                ],
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(nickname,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0)),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Text(
                                        messages.data.documents[0]['text'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0,
                                            color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(formatter.format(date),
                                  style: TextStyle(fontSize: 12.0)),
                              SizedBox(height: 5.0),
                              unread
                                  ? Container(
                                      width: 40.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                          color: Hexcolor("#F4AA33"),
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      alignment: Alignment.center,
                                      child: Text('NEW',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold)))
                                  : Text('')
                            ],
                          ),
                        ],
                      );
                    }
                  }),
            );
          }
        },
      ),
    );
  }
}
