import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: Column(
//                  children: <Widget>[
////                    CircleAvatar(backgroundImage: Image.asset('images/blank.jpg'),),
////                  ],
//                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
