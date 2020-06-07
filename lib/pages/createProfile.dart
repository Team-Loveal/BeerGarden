import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/foundation.dart';
import "package:lovealapp/services/auth.dart";
import 'package:lovealapp/shared/loading.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final AuthService _auth = AuthService();

  String nickname;
  String location;
  String age;
  String gender;
  String occupation;
  String about;
  String interests;

  //for loading spinner
  bool loading = false;

//  String age = '20 - 29';
//  String gender = 'Female';
//  List<bool> isSelected;
//
//  @override
//  void initState() {
//    super.initState();
//    isSelected = [
//      true,
//      false,
//      true,
//      false,
//      false,
//      false,
//      false,
//      false,
//      false,
//      false
//    ];
//  }
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (val) {
                          setState(() => nickname = val);
                        },
                        decoration: InputDecoration(
                            labelText: 'Choose a nickname to display to users'),
                        keyboardType: TextInputType.text,
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() => location = val);
                        },
                        decoration:
                            InputDecoration(labelText: 'Enter your Location'),
                        keyboardType: TextInputType.text,
                      ),
                      Row(
                        children: <Widget>[
                          Text('Age'),
                          DropdownButton<String>(
                            value: age,
                            iconSize: 24,
                            onChanged: (String newValue) {
                              setState(() {
                                age = newValue;
                              });
                            },
                            items: <String>[
                              '20 - 29',
                              '30 - 39',
                              '40 - 49',
                              '50 - 59',
                              '60 - 69'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() => occupation = val);
                        },
                        decoration:
                            InputDecoration(labelText: 'Enter your occupation'),
                        keyboardType: TextInputType.text,
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() => about = val);
                        },
                        decoration: InputDecoration(
                            labelText: 'Share something about yourself'),
                        keyboardType: TextInputType.text,
                      ),
                      TextField(
                        onChanged: (val) {
                          setState(() => interests = val);
                        },
                        decoration: InputDecoration(
                            labelText: 'What are your interests?'),
                        keyboardType: TextInputType.text,
                      )
//          ToggleButtons(
//            children: <Widget>[
//              Text("murder"),
//              Text("dance murder"),
//              Text("pancakes"),
//              Text("yodle"),
//              Text("sky diving"),
//              Text("turtles"),
//              Text("watching harry potter"),
//              Text("1 person dance parties"),
//              Text("sleep"),
//              Text("swimming")
//            ],
//            onPressed: (int index) {
//              setState(() {
//                isSelected[index] = !isSelected[index];
//              });
//            },
//            isSelected: isSelected,
//          ),
                    ],
                  )),
            ),
          );
  }
}
