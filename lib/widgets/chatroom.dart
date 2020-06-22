import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lovealapp/widgets/unmatchDialog.dart';
import 'package:lovealapp/pages/message.dart';

Widget buildChatroom(DocumentSnapshot document, BuildContext context) {
  final user = Provider.of<User>(context);
  var matchID =
      document['fromID'] != user.uid ? document['fromID'] : document['toID'];
  var formatter = new DateFormat('MMMMd');
  bool unread = false;
  DateTime date;
  String nickname;
  String imgUrl;

  // for blur
  var sigmaX = document['blur'].toDouble();
  var sigmaY = document['blur'].toDouble();

  return Slidable(
    actionPane: SlidableDrawerActionPane(),
    actionExtentRatio: 0.25,
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Unmatch',
        color: Colors.red,
        icon: MdiIcons.accountOff,
        onTap: () =>
            {showAlertDialog(context, document.documentID, matchID, nickname)},
      ),
    ],
    child: GestureDetector(
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
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: unread
                                        ? Hexcolor("#8CC63E")
                                        : Hexcolor('#f1f4f5'),
                                    radius: 38,
                                    child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(imgUrl)),
                                  ),
                                  Container(
                                      width: 70,
                                      height: 70,
                                      child: ClipOval(
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: sigmaX ?? 50,
                                                sigmaY: sigmaY ?? 50),
                                            child: Container(
                                                color: Colors.black
                                                    .withOpacity(0))),
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
                                        messages.data.documents[0]['text'] ==
                                                "sendBeer"
                                            ? "🍻"
                                            : messages.data.documents[0]
                                                ['text'],
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
                                          color: Hexcolor("#8CC63E"),
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
    ),
  );
}
