import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/match.dart';
import 'package:lovealapp/pages/messagesList.dart';
import 'package:lovealapp/pages/myProfile.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/services/database.dart';
import 'package:provider/provider.dart';

class NavigationHome extends StatefulWidget {
  final int newIdx;

  NavigationHome({Key key, @required this.newIdx}) : super(key: key);

  @override
  _NavigationHomeState createState() => _NavigationHomeState(newIdx);
}

class _NavigationHomeState extends State<NavigationHome> {
  final int newIdx;

  _NavigationHomeState(this.newIdx);

  int _currentIndex = 0;

  final List<Widget> _children = [
    Match(),
    Messages(),
    MyProfile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userData,
      child: Scaffold(
        body: (newIdx == null) ? _children[_currentIndex] : _children[newIdx],
        bottomNavigationBar: BottomNavigationBar(
          // new
            backgroundColor: Hexcolor("#8CC63E"),
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite, color: Colors.white),
                title: new Text('Match',
                    style: TextStyle(fontFamily: 'Alata', color: Colors.white)),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.message, color: Colors.white),
                title: new Text('Messages',
                    style: TextStyle(fontFamily: 'Alata', color: Colors.white)),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.white),
                  title: Text('Profile',
                      style:
                      TextStyle(fontFamily: 'Alata', color: Colors.white)))
            ]),
      ),
    );
  }
}