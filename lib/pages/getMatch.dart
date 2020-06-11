import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/services/auth.dart';

class GetMatch extends StatefulWidget {
  @override
  _GetMatchState createState() => _GetMatchState();
}

class _GetMatchState extends State<GetMatch> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
//            int matches = userData.matches;
            return Scaffold(
              body: Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //for testing purposes
                      FlatButton.icon(
                        icon: Icon(Icons.person),
                        label: Text("logout"),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                      FlatButton(
                        color: Colors.pinkAccent,
                        child: Text('Get your new match for the day <3',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {
                          //add matches by one
                          int matches = userData.matches + 1;

                          //find a user where matched is false
                          Firestore.instance
                              .collection("messages")
                              .where('fromID', isEqualTo: user.uid)
                              .getDocuments()
                              .then((data) => data.documents.forEach((doc) => {
                                    if (!doc['matched'])
                                      {
                                        print(
                                            'found unmatched user $doc.toID and $doc.documentID'),
                                        Firestore.instance
                                            .collection('users')
                                            .document(user.uid)
                                            .updateData({
                                          'matchID': doc['toID'],
                                          'chatID': doc.documentID,
                                          'matches': matches,
                                        }),
                                        print(
                                            'updated user collection with matchID: $doc.toID')
                                      }
                                  }));

                          //go to matched Profile page
                          Navigator.of(context).pushNamed('/navigationHome');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
            // ignore: missing_return
          } else {
            Loading();
          }
        });
  }
}
