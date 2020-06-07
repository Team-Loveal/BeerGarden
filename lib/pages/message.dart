import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

String _name = 'Ugly Jeff'; // TODO replace with peer userName

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  String chatRoomID;
  var listMessages;

  @override
  void initState() {
    super.initState();

    // TODO replace hardcoded chatRoomID (userID-userID)
    chatRoomID = "5WADFQiHEses3riWV9JxaYJNrGM2-b7fXewrdeaPJ814w5A0qvKo4cuH3";
  }

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
                color: Colors.pinkAccent,
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
          .collection(chatRoomID)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'fromID': "testpig", // replace with var id
            'toID': "testmonkey", // replace with var peerID
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'text': text,
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
    return Scaffold(
        // TODO add a return button to navigate back to messagesList
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              icon: Icon(MdiIcons.arrowLeft)),
          title: Text("Ugly Jeff", style: TextStyle(color: Colors.pinkAccent),
              onPressed: () {
            // TODO navigate to user profile
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
                        .collection(chatRoomID)
                        .orderBy('timestamp', descending: true)
                        .limit(20)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        listMessages = snapshot.data.documents;
                        return ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          reverse: true,
                          // builds widget for each message in the database
                          itemBuilder: (context, index) => buildMessage(
                              index, snapshot.data.documents[index], context),
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

  // For each message bubble
  Widget buildMessage(
      int index, DocumentSnapshot document, BuildContext context) {
    // TODO replace with user id
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: document['fromID'] == 'testpig'
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
                  document['fromID'] == 'testpig' ? Colors.white : Colors.pink,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Text(document['text'],
                style: TextStyle(color: Colors.black, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
