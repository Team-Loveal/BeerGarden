import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              // height: 150.0,
              // padding: EdgeInsets.only(top: 20.0),
              child: Text('Messages',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 42)),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .where('matchedUsers', arrayContains: user.uid)
                      .where('matched', isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => buildChatroom(
                            snapshot.data.documents[index], context),
                        itemCount: snapshot.data.documents.length,
                      );
                    }
                  }),
            ),
          ],
        ));
  }

  Widget buildChatroom(DocumentSnapshot document, BuildContext context) {
    final user = Provider.of<User>(context);
    var matchID = document['matchedUsers'].firstWhere((id) => id != user.uid);

    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection('users')
                    .document(matchID)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      radius: 50,
                      child: CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              NetworkImage(snapshot.data['imgUrl'])),
                    );
                  }
                }),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FutureBuilder<DocumentSnapshot>(
                        future: Firestore.instance
                            .collection('users')
                            .document(matchID)
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(snapshot.data['nickname'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26)),
                              Text('May 2nd'),
                            ],
                          );
                        }),
                    Text('Message Message')
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
