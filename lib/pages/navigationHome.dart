import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/match.dart';
import 'package:lovealapp/pages/messagesList.dart';
import 'package:lovealapp/pages/myProfile.dart';
import 'package:lovealapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationHome extends StatefulWidget {
  NavigationHome({Key key, this.newIdx}) : super(key: key);
  final int newIdx;

  @override
  _NavigationHomeState createState() => _NavigationHomeState(newIdx);
}

class _NavigationHomeState extends State<NavigationHome> {
  int newIdx;

  _NavigationHomeState(this.newIdx);

  int _currentIndex = 0;

  final List<Widget> _children = [
    Match(),
    Messages(),
    MyProfile(),
  ];

  void onTabTapped(int index) {
    HapticFeedback.heavyImpact();
   // HapticFeedback.mediumImpact();
    setState(() {
      if (newIdx is int) {
        newIdx = null;
      }
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (newIdx != null) _currentIndex = newIdx;

    return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: Scaffold(
          body: (newIdx == null) ? _children[_currentIndex] : _children[newIdx],
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentIndex,
            color: Hexcolor('#F4AA33'),
            backgroundColor: Colors.white,
            buttonBackgroundColor: Hexcolor('#F4AA33'),
            animationDuration: Duration(milliseconds: 300),
            height: 60.0,
            items: <Widget>[
              Icon(MdiIcons.glassMugVariant, size: 35, color: Colors.white),
              Icon(MdiIcons.messageText, size: 35, color: Colors.white),
              Icon(Icons.person, size: 35, color: Colors.white),
            ],
            onTap: onTabTapped,
          ),
        ));
  }
}
