import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/widgets/chatroom.dart';
import 'package:hexcolor/hexcolor.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
                                        buildChatroom(
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
}
