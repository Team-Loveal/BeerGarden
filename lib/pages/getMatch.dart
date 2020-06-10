import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/pages/navigationHome.dart';

class GetMatch extends StatefulWidget {
  @override
  _GetMatchState createState() => _GetMatchState();
}

class _GetMatchState extends State<GetMatch> {
  String matchID;
  String chatID;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
//    final userData = Provider.of<UserData>(context);
    return Container(
      child: FlatButton(
          onPressed: () => {
                print('clicked'),
                //find a user where matched is false
                Firestore.instance
                    .collection("messages")
                    .where('fromID', isEqualTo: user.uid)
                    .snapshots()
                    .listen((data) => data.documents.forEach((doc) => {
                          //if matched is false
                          if (!doc['matched'])
                            {
                              matchID = doc['toID'],
                              chatID = doc.documentID,
                            }
                        })),
                //store matched users id in the db
                Firestore.instance
                    .collection('users')
                    .document(user.uid)
                    .updateData({'matchID': matchID, 'chatID': chatID}),
                //go to matched Profile page
                Navigator.of(context).pushNamed('/navigationHome')
              },
          textColor: Colors.pink,
          child: Text(
            'Get Match for the day',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
    );
  }
}
