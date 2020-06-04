import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  //for reading the contents of the input field and for clearing the field after the text message is sent
  final _textController = TextEditingController();
  void _handleSubmitted(String text) {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages", style: TextStyle(color: Colors.pinkAccent)),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
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
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),

            //SEND BUTTON
            //icons inherit their color and style from IconTheme widget
            IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
