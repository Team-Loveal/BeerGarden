import 'package:flutter/material.dart';
//for chat bubble
import 'package:bubble/bubble.dart';

String _name = 'Ugly Jeff';

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
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
              onSubmitted: _handleSubmitted,
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
                onPressed: () => _handleSubmitted(_textController.text)),
          ),
        ],
      ),
    );
  }

  //for reading the contents of the input field and for clearing the field after the text message is sent
  final _textController = TextEditingController();

  //each item in this list is a ChatMessage instance
  final List<ChatMessage> _messages = [];

  final FocusNode _focusNode = FocusNode();

  void _handleSubmitted(String text) {
    _textController.clear();

    //Create a ChatMessage instance
    ChatMessage message = ChatMessage(text: text);

    //Calling setState to modify _messages lets the framework know that this part of the widget tree has changed it needs to rebuild
    //Only synchronous operations should be performed in setState() otherwise the framework
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
  }

  //BASICALLY THE BODY
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ugly Jeff", style: TextStyle(color: Colors.pinkAccent)),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Column(
          //LIST OF MESSAGES
          children: <Widget>[
            Flexible(
              //builds a list on demand by providing a function that is called once per item in the list
              //the function returns a new widget at each call
              //the builder automatically detects mutations of its children parameter and initiates a rebuild
              //parameters passed in customize the list contents and appearance
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            //INPUT MESSAGE FIELD
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextInput(),
            ),
          ],
        ));
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});
  final String text;
  //replace with text variable for the real thing

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Bubble(
              nip: BubbleNip.leftTop,
              color: Colors.pinkAccent,
              margin: BubbleEdges.only(top: 8.0),
              child: Text(text, style: TextStyle(color: Colors.black87)),
            ),
            ],
          ),
        ],
      ),
//      child: SizedBox(
//        height: 400,
//        child: ListView(
//          padding: EdgeInsets.all(8.0),
//          children: [
//            Bubble(
//              nip: BubbleNip.leftTop,
//              color: Colors.pinkAccent,
//              margin: BubbleEdges.only(top: 8.0),
//              child: Text(text, style: TextStyle(color: Colors.black87)),
//            ),
//            Bubble(
//              margin: BubbleEdges.only(top: 8.0),
//              nip: BubbleNip.rightTop,
//              color: Colors.yellowAccent,
//              child: Text("Hello",
//                  style: TextStyle(color: Colors.black87),
//                  textAlign: TextAlign.right),
//            ),
//          ],
//        ),
//      ),
    );
  }
}
