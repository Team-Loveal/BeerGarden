import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';



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

  //for Form key => provide access to other object
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //this is providing the user object
    final user = Provider.of<User>(context);

    return loading
        ? Loading()
        : Scaffold(
//            backgroundColor: Hexcolor('#fff6c2'),
//            appBar: AppBar(
//              backgroundColor: Hexcolor('#f08080'),
//              title: Text(
//                'test',
//                style: TextStyle(
//                  color: Colors.white,
//                ),
//              ),
//            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: key,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              validator: (value) => !(value.length < 4) ? 'Nickname must be at least 4 characters': null,

                              cursorWidth: 3,
                              maxLength: 35,
                              //comment out for testing
//                            onChanged: (val) {
//                              setState(() => nickname = val);
//                            },

                              onSaved: (String value) {
                                //this block is used to run code when a user save the form
                                nickname = value;
                              },

                              decoration: InputDecoration(
                                  hintText:
                                      'Choose a nickname to display to users',
                                  labelText: 'Nickname *'),
//                            validator: (String value) {
//                              return value.length < 3
//                                  ? 'Nickname is required'
//                                  : null;
//                            },
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          TextFormField(
                            validator: (value) => !(value.length < 2) ? 'Location must be provided': null,
                            cursorWidth: 3,
//                              onChanged: (val) {
//                                setState(() => location = val);
//                              },
                            onSaved: (String value) {
                              location = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'Tokyo', labelText: 'Location *'),
                            keyboardType: TextInputType.text,
                          ),
                          Row(
                            children: <Widget>[
                              Text('Age *'),
                              DropdownButtonFormField<String>(
                                value: age,
                                iconSize: 24,
                                onChanged: (String newValue) {
                                  setState(() {
                                    age = newValue;
                                  });
                                },
                                validator: (value) => value == null ? 'Select your age' : null,
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
                                "Gender *",
                              ),
                              DropdownButtonFormField<String>(
                                value: gender,
                                iconSize: 24,
                                onChanged: (String newValue) {
                                  setState(() {
                                    gender = newValue;
                                  });
                                },
                                validator: (value) => value == null ? 'Select your gender' : null,
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
                          TextFormField(
                            validator: (value) => !(value.length < 4) ? 'Tell us about yourself': null,
//                            onChanged: (val) {
//                              setState(() => about = val);
//                            },
                          onSaved: (String value){
                            about = value;
                          },
                            decoration: InputDecoration(
                                labelText: 'Share something about yourself *'),
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
                                    selectedColor: Hexcolor('#ffb55a'),
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
                                    selectedColor: Hexcolor('#215a00'),
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
                                    selectedColor: Hexcolor('#efcfe3'),
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
                                    selectedColor: Hexcolor('#b3dee2'),
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
                                    selectedColor: Hexcolor('#c2bbf0'),
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
                                    selectedColor: Hexcolor('#b0f2b4'),
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
                                    selectedColor: Hexcolor('#ef7674'),
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
                                    selectedColor: Hexcolor('#3a7ca5'),
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
                                    selectedColor: Hexcolor('#ffbf69'),
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
                                //added following lines
                                if (this.key.currentState.validate()){
                                  this.key.currentState.save();
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
                                }
                                //write profile info into the db

                              },
                              textColor: Colors.white,
                              color: Hexcolor('#f08080'),
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
                      ),
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
