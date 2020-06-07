import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';


import 'package:flutter/foundation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateProfile extends StatefulWidget {

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String age = '20 - 29';
  String gender = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Choose a nickname to display to users'
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your Location'
                ),
                keyboardType: TextInputType.text,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Age'
                  ),
                  DropdownButton<String>(
                    value: age,
                    iconSize: 24,
                    onChanged: (String newValue) {
                      setState(() {
                        age = newValue;
                      });
                    },
                    items: <String>['20 - 29', '30 - 39', '40 - 49', '50 - 59', '60 - 69']
                        .map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                  Text(
                    "Gender",
                  ),
                  DropdownButton<String>(
                    value: gender,
                    iconSize: 24,
                    onChanged: (String newValue) {
                      setState(() {
                        gender = newValue;
                      });
                    },
                    items: <String>['Female', 'Male', 'Other']
                        .map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Enter your occupation'
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Share something about yourself'
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'What are your interests?'
                ),
                keyboardType: TextInputType.text,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/uploadphoto');
                  },
                  textColor: Colors.white,
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    children: <Widget>[
                      Text('GO TO UPLOAD PHOTO  ',
                      style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                      Icon(MdiIcons.arrowRight, size: 18)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),

              )
                ],
              ),
              ),
          ),
    );
  }
}
