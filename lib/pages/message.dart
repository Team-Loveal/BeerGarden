import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/models/user.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'profile.dart';

//adding for transition animation
import 'package:page_transition/page_transition.dart';

class Message extends StatefulWidget {
  Message(
      {Key key,
      @required this.chatRoomID,
      this.matchID,
      this.nickname,
      this.imgUrl})
      : super(key: key);

  final String chatRoomID;
  final String matchID;
  final String nickname;
  final String imgUrl;

  @override
  _MessageState createState() =>
      _MessageState(chatRoomID, matchID, nickname, imgUrl);
}

class _MessageState extends State<Message> {
  _MessageState(this.chatRoomID, this.matchID, this.nickname, this.imgUrl);

  final String chatRoomID;
  final String matchID;
  final String nickname;
  final String imgUrl;
  final dbRef = Firestore.instance;
  // user context from provider
  var user;
  var toID;

  //for blur
  double sigmaX;
  double sigmaY;
  bool activeChat;

  //for reading the contents of the input field and for clearing the field after the text message is sent
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // inorder to back to message list from message
  int profileIndex = 1;

  @override
  void initState() {
    super.initState();
    _getChatted();
    _setBlur();
  }

  void _setBlur() {
    //get matchID and chatID from db
    Firestore.instance
        .collection('messages')
        .document(chatRoomID)
        .get()
        .then((doc) {
      setState(() {
        sigmaX = doc['blur'].toDouble();
        sigmaY = doc['blur'].toDouble();
      });
    });
  }

  // check if chatroom is active
  void _getChatted() async {
    await dbRef
        .collection('messages')
        .document(chatRoomID)
        .get()
        .then((snapshot) => {
              activeChat = snapshot['active']
//              if (snapshot['active'] != null)
//                {activeChat = snapshot['active']}
//              else
//                {_activateChat(false), activeChat = false}
            });
  }

  // activate chatroom (a chatroom that has at least one message)
  void _activateChat(bool) async {
    await dbRef
        .collection('messages')
        .document(chatRoomID)
        .updateData({'active': bool}).catchError(
            (err) => {print('Error activating chat: ${err.toString()}')});
  }

  void _toggleUnread(DocumentSnapshot document) async {
    await dbRef
        .collection('messages')
        .document(chatRoomID)
        .collection('chatroom')
        .document(document.documentID)
        .updateData({'unread': false});
  }

  void _onSendMessage(String text) {
    // toggle chatted if first message
    if (!activeChat) {
      _activateChat(true);
    }

    if (text.trim() != "") {
      _textController.clear();
      var documentReference = dbRef
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

  void _onSendBeer() async {
    // toggle chatted if first message
    if (!activeChat) {
      _activateChat(true);
    }

    var documentReference = dbRef
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
          'text': 'sendBeer',
          'unread': true,
        },
      );
    });
  }

  // BODY
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    return Scaffold(
        backgroundColor: Hexcolor("#F4AA33"),
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: AppBar(
            backgroundColor: Hexcolor("#F4AA33"),
            leading: IconButton(
                onPressed: () {
                  // this is the original code
//                  Navigator.pop(context); // takes back to the original page
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.scale,
                        child: NavigationHome(newIdx: profileIndex)),
                  );
                },
                icon: Icon(MdiIcons.arrowLeft)),
            flexibleSpace: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                            userID: matchID,
                            nickname: nickname,
                            imgUrl: imgUrl,
                            chatRoomID: chatRoomID)));
              },
              child: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 29,
                            backgroundImage: NetworkImage(imgUrl),
                          ),
                          Container(
                              width: 58,
                              height: 58,
                              child: ClipOval(
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: sigmaX ?? 50,
                                        sigmaY: sigmaY ?? 50),
                                    child: Container(
                                        color: Colors.black.withOpacity(0))),
                              )),
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        nickname,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            elevation: 0.0,
            centerTitle: true,
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    //LIST OF MESSAGES
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Hexcolor('#f1f4f5'),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            // builds a list of messages from database
                            // updated in realtime with stream
                            child: StreamBuilder(
                                stream: dbRef
                                    .collection('messages')
                                    .document(chatRoomID)
                                    .collection('chatroom')
                                    .orderBy('timestamp', descending: true)
                                    .limit(20)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Loading(),
                                    );
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(8.0),
                                        reverse: true,
                                        // builds widget for each message in the database
                                        itemBuilder: (context, index) =>
                                            _chatBubble(
                                                snapshot.data.documents[index],
                                                context),
                                        itemCount:
                                            snapshot.data.documents.length,
                                      ),
                                    );
                                  }
                                })),
                      ),
                      //INPUT MESSAGE FIELD
                      Container(
                        decoration:
                            BoxDecoration(color: Theme.of(context).cardColor),
                        child: _buildTextInput(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // MESSAGE INPUT AND SEND
  Widget _buildTextInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      height: 70.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              color: Hexcolor('#F4AA33'),
              icon: Icon(MdiIcons.glassMugVariant, size: 38.0),
              onPressed: () => _onSendBeer()),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor('#f1f4f5'),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: TextField(
                controller: _textController,
                onSubmitted: _onSendMessage,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    hintText: "Send a message...",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0)),
              ),
            ),
          ),
          SizedBox(width: 5),
          Container(
            child: IconButton(
                color: Hexcolor('#F4AA33'),
                icon: Icon(Icons.send, size: 38.0),
                onPressed: () => {
                      _onSendMessage(_textController.text),
                      FocusScope.of(context).unfocus()
                    }),
          ),
        ],
      ),
    );
  }

  // For each message bubble
  Widget _chatBubble(DocumentSnapshot document, BuildContext context) {
    bool isUser;
    DateTime date;
    Widget time;
    var formatter;

    isUser = document['fromID'] == user.uid;
    // Format time to readable HH:MM
    date = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(document['timestamp']));
    formatter = new DateFormat('Hm');
    time = Text(formatter.format(date),
        style: TextStyle(fontSize: 12.0, color: Colors.grey));

    if (document['fromID'] != user.uid) {
      _toggleUnread(document);
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              isUser
                  ? Row(
                      children: <Widget>[time, SizedBox(width: 10.0)],
                    )
                  : Container(),
              document['text'] == 'sendBeer'
                  ? Container(
                      child: Image.asset('images/cheers.gif',
                          width: 100.0, height: 100.0, fit: BoxFit.fitWidth))
                  : Container(
                      padding: const EdgeInsets.all(15.0),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.white : Hexcolor("#8CC63E"),
                        borderRadius: isUser
                            ? BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              )
                            : BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                      ),
                      child: Text(document['text'],
                          style: TextStyle(
                              color: isUser ? Colors.black : Colors.white,
                              fontSize: 14)),
                    ),
              !isUser
                  ? Row(
                      children: <Widget>[SizedBox(width: 10.0), time],
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
