import 'package:flutter/material.dart';
import 'package:chat_list/chat_list.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UglyJeff', style: TextStyle(color: Colors.pinkAccent)),
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }
}
