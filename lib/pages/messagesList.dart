import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String chatroomID =
      "5WADFQiHEses3riWV9JxaYJNrGM2-b7fXewrdeaPJ814w5A0qvKo4cuH3";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    debugPrint('User: ${user.uid}');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Messages',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .where('fromID',
                          isEqualTo: 'i7CWlm6grKQGMkZkIrIBubcZjOF2')
                      .where('chatted', isEqualTo: true)
                      .snapshots(), // TODO replace with chatRoomId
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
    var doc = document.reference
        .collection('chatroom')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .getDocuments()
        .then((data) => {
              if (data.documents.length > 0) {print(data.documents[0].data)}
            });

    var nickname = Firestore.instance
        .collection('users')
        .document('WI4AaMen5ZP0ih4TRzE5TDP5qj22')
        .get()
        .then((value) => value.data['nickname']);

    print(nickname);
    // TODO find toID and fetch nickname from users document
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: Colors.pinkAccent,
              radius: 50,
              child: CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage(
                      'https://mymodernmet.com/wp/wp-content/uploads/2017/01/animal-selfies-5.jpg')),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nickname',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Message Message')
                ]),
          ),
          Expanded(child: Text('May 2nd')),
        ],
      ),
    );
  }
}
