import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/foundation.dart';
import 'package:lovealapp/models/user.dart';
import "package:lovealapp/services/auth.dart";
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

//CHANGE LOCATION TO DROPDOWN OF PREFECTURES IN JAPAN

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String nickname;
  String location;
  String age;
  String gender;
  String occupation;
  String about;
  List interests;
  //for interests
  bool yodeling = false;
  bool shopping = false;
  bool makingBalloonAnimals = false;
  bool cooking = false;
  bool painting = false;
  bool movies = false;
  bool sports = false;
  bool writing = false;
  bool drinking = false;

  //for loading spinner
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //this is providing the user object
    final user = Provider.of<User>(context);

    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          onChanged: (val) {
                            setState(() => nickname = val);
                          },
                          decoration: InputDecoration(
                              labelText:
                                  'Choose a nickname to display to users'),
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
                              items: <String>[
                                'Female',
                                'Male',
                                'Other'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                          decoration: InputDecoration(
                              labelText: 'Enter your occupation'),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('What are your interests?'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 5,
                              runSpacing: 3,
                              children: <Widget>[
                                FilterChip(
                                  label: Text('yodeling'),
                                  selected: yodeling,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      yodeling = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('shopping'),
                                  selected: shopping,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      shopping = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('making balloon animals'),
                                  selected: makingBalloonAnimals,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      makingBalloonAnimals = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('cooking'),
                                  selected: cooking,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      cooking = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('painting'),
                                  selected: painting,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      painting = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('writing'),
                                  selected: writing,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      writing = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('sports'),
                                  selected: sports,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      sports = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('movies'),
                                  selected: movies,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      movies = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                                FilterChip(
                                  label: Text('drinking'),
                                  selected: drinking,
                                  onSelected: (isSelected) {
                                    setState(() {
                                      drinking = isSelected;
                                    });
                                  },
                                  selectedColor: Colors.pink[400],
                                  checkmarkColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                          child: RaisedButton(
                            onPressed: () async {
                              //write profile info into the db
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                nickname,
                                location,
                                age,
                                gender,
                                occupation,
                                about,
                                yodeling,
                                shopping,
                                makingBalloonAnimals,
                                cooking,
                                painting,
                                movies,
                                sports,
                                writing,
                                drinking,
                              );
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Icon(MdiIcons.arrowRight, size: 18)
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
  }
}

// the code below was used for the chip thing. It worked fine but I wasn't able to get the boolean for each chip, so I commented out for now.
// I just hard code every chip for now
// probably we can use it later
// Yuya 6/8/2020

//class filterChipWidget extends StatefulWidget {
//  final String chipName;
//  final bool yodeling;
//  final bool shopping;
//
//  filterChipWidget({Key key, this.chipName, this.yodeling, this.shopping}) : super(key: key);
//
//  @override
//  _filterChipWidgetState createState() => _filterChipWidgetState();
//}
//
//class _filterChipWidgetState extends State<filterChipWidget> {
//  var _isSelected = false;
//  @override
//  Widget build(BuildContext context) {
//    return FilterChip(
//      label: Text(widget.chipName),
//      selected: _isSelected,
//      onSelected: (isSelected){
//        setState(() {
//          _isSelected = isSelected;
//        });
//      },
//      selectedColor: Colors.pink[400],
//    checkmarkColor: Colors.white,
//    );
//  }
//}
