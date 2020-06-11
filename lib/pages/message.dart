import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/models/user.dart';
import 'package:hexcolor/hexcolor.dart';

class Message extends StatefulWidget {
  final String chatRoomID;
  final String matchID;
  Message({Key key, @required this.chatRoomID, this.matchID}) : super(key: key);

  @override
  _MessageState createState() => _MessageState(chatRoomID, matchID);
}

class _MessageState extends State<Message> {
  final String chatRoomID;
  final String matchID;
  _MessageState(this.chatRoomID, this.matchID);

  // user context from provider
  var user;
  var toID;

  //MESSAGE INPUT AND SEND
  Widget _buildTextInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          //TEXT INPUT
          //Flexible tells the Row to automatically size the text field to use the remaining space that isn't used by the button
          Flexible(
            child: TextField(
              controller: _textController,
              //onSubmitted provides a private callback method
              //at first this method just clears the field
              onSubmitted: _onSendMessage,
              decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              focusNode: _focusNode,
            ),
          ),

          //SEND BUTTON
          //icons inherit their color and style from IconTheme widget
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                color: Hexcolor("#C3C3E6"),
                icon: const Icon(Icons.send),
                onPressed: () => _onSendMessage(_textController.text)),
          ),
        ],
      ),
    );
  }

  //for reading the contents of the input field and for clearing the field after the text message is sent
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _onSendMessage(String text) {
    if (text.trim() != "") {
      _textController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(chatRoomID)
          .collection('chatroom')
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'fromID': user.uid,
            'toID': matchID,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'text': text,
            'unread': true,
          },
        );
      });
    } else {
      // Show error message to user
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  //BASICALLY THE BODY
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Hexcolor("#FFF4EB"),
        appBar: AppBar(
          backgroundColor: Hexcolor("#F08080"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(MdiIcons.arrowLeft)),
          title: FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('users')
                  .document(matchID)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Text(
                    snapshot.data['nickname'],
                    style: TextStyle(color: Hexcolor("#3c3c3c")),
                  );
                }
              }),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Column(
          //LIST OF MESSAGES
          children: <Widget>[
            Flexible(
                // builds a list of messages from database
                // updated in realtime with stream
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('messages')
                        .document(chatRoomID)
                        .collection('chatroom')
                        .orderBy('timestamp', descending: true)
                        .limit(20)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          reverse: true,
                          // builds widget for each message in the database
                          itemBuilder: (context, index) => buildMessage(
                              snapshot.data.documents[index], context),
                          itemCount: snapshot.data.documents.length,
                        );
                      }
                    })),
            Divider(height: 1.0),
            //INPUT MESSAGE FIELD
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextInput(),
            ),
          ],
        ));
  }

  void toggleUnread(DocumentSnapshot document) {
    Firestore.instance
        .collection('messages')
        .document(chatRoomID)
        .collection('chatroom')
        .document(document.documentID)
        .updateData({'unread': false});
  }

  // For each message bubble
  Widget buildMessage(DocumentSnapshot document, BuildContext context) {
    if (document['fromID'] != user.uid) {
      toggleUnread(document);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: document['fromID'] == user.uid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color:
                  document['fromID'] == user.uid ? Hexcolor("#F5F5F5") : Hexcolor("#D1C8E1"),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Text(document['text'],
                style: TextStyle(color: Hexcolor("#3c3c3c"), fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
