import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //use map to get messages from array
        child: ListView(children: <Widget>[
          //Messages heading
          Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Text('Messages',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ))),
          //Messages
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2017/06/13/12/53/profile-2398782_1280.png'),
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
          ),
        ]),
      ),
    );
  }
}
