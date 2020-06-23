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

// change the color green to white and get rid of the check mark

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String nickname;
  String location;
  int age;
  String gender;
  String occupation;
  String about;

  //List interests;

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

  //preferences
  double _lowValue = 18;
  double _highValue = 100;
  String genderPreference = 'Everyone';

  //form global key
  final _formKey = GlobalKey<FormState>();

  //for selected text feild
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Hexcolor("#FFF6C2"),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  //background gradient
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Hexcolor('#FFF1BA'),
                          Hexcolor('#F4AA33'),
                        ],
                        stops: [0.2, 0.7],
                      ),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    '🍺Your Profile🍺',
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    controller: _controller,
                                    cursorWidth: 3,
                                    maxLength: 20,
                                    onChanged: (val) {
                                      setState(() => nickname = val);
                                    },
                                    onSaved: (String value) {
                                      //this block is used to run code when a user save the form
                                    },
                                    onTap: () {},
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      prefixIcon: Icon(Icons.account_circle),
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Nickname *',
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a nickname';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text('Age'),
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<
                                                    int>(
                                                  decoration: InputDecoration(
                                                      enabledBorder: InputBorder.none,
                                                  ),
                                                  validator: (value) => value ==
                                                          null
                                                      ? 'Please tell us your age'
                                                      : null,
                                                  value: age,
                                                  iconSize: 24,
                                                  iconEnabledColor: Colors.orangeAccent,
                                                  onChanged: (int newValue) {
                                                    setState(() {
                                                      age = newValue;
                                                    });
                                                  },
                                                  items: <int>[
                                                    18,
                                                    19,
                                                    20,
                                                    21,
                                                    22,
                                                    23,
                                                    24,
                                                    25,
                                                    26,
                                                    27,
                                                    28,
                                                    29,
                                                    30,
                                                    31,
                                                    32,
                                                    33,
                                                    34,
                                                    35,
                                                    36,
                                                    37,
                                                    38,
                                                    39,
                                                    40,
                                                    41,
                                                    42,
                                                    43,
                                                    44,
                                                    45,
                                                    46,
                                                    47,
                                                    48,
                                                    49,
                                                    50,
                                                    51,
                                                    52,
                                                    53,
                                                    54,
                                                    55,
                                                    56,
                                                    57,
                                                    58,
                                                    59,
                                                    60,
                                                    61,
                                                    62,
                                                    63,
                                                    64,
                                                    65,
                                                    66,
                                                    67,
                                                    68,
                                                    69,
                                                    70,
                                                    71,
                                                    72,
                                                    73,
                                                    74,
                                                    75,
                                                    76,
                                                    77,
                                                    78,
                                                    79,
                                                    80
                                                  ].map<DropdownMenuItem<int>>(
                                                      (int value) {
                                                    return DropdownMenuItem<
                                                        int>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Text(
                                                            value.toString()),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                         decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Gender",
                                                ),
                                              ),
                                              Expanded(
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                    enabledBorder: InputBorder.none),
                                                  validator: (value) => value ==
                                                          null
                                                      ? 'Please tell us your gender'
                                                      : null,
                                                  value: gender,
                                                  iconSize: 24,
                                                  iconEnabledColor: Colors.orangeAccent,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      gender = newValue;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Female',
                                                    'Male',
                                                    'Rather not say'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(value),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    cursorWidth: 3,
                                    onChanged: (val) {
                                      setState(() => location = val);
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.location_on),
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Enter your Location *',
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your location';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() => occupation = val);
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      prefixIcon: Icon(Icons.work),
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Occupation *',
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your occupation';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    onChanged: (val) {
                                      setState(() => about = val);
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      prefixIcon: Icon(Icons.thumb_up),
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          'Share something about yourself *',
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter something about yourself';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Text('What are your interests?',
                                      style: TextStyle(fontSize: 20.0)),
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
                                          showCheckmark: false,
                                          label: Text(
                                            'Games',
                                            style:
                                            yodeling ?
                                                TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: yodeling,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              yodeling = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Shopping',
                                            style:
                                            shopping ?
                                                TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: shopping,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              shopping = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Photography',
                                              style:
                                              makingBalloonAnimals ?
                                              TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: makingBalloonAnimals,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              makingBalloonAnimals = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Art',
                                            style: painting ?
                                            TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: painting,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              painting = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Traveling',
                                            style:
                                            writing ?
                                            TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: writing,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              writing = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Sports',
                                            style:
                                            sports ?
                                            TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: sports,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              sports = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Movies',
                                            style:
                                            movies ?
                                            TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: movies,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              movies = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Drinking',
                                            style:
                                            drinking ?
                                            TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: drinking,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              drinking = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                        FilterChip(
                                          showCheckmark: false,
                                          label: Text(
                                            'Karaoke',
                                            style:
                                            cooking?
                                            TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                                          ),
                                          selected: cooking,
                                          onSelected: (isSelected) {
                                            setState(() {
                                              cooking = isSelected;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          selectedColor: Hexcolor("#8CC63E"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Text(
                                    'Your Preferences',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Show Me",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20),)
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: genderPreference,
                                        iconSize: 24,
                                        iconEnabledColor: Colors.orangeAccent,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            genderPreference = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Female',
                                          'Male',
                                          'Everyone'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(value,
                                                  style: TextStyle(fontSize: 20.0)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Text(
                                            'Age Range',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: Text(
                                            '${_lowValue.toInt().toString()} - ${_highValue.toInt().toString()}',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        )
                                      ],
                                    ),
                                    RangeSlider(
                                      min: 18,
                                      max: 100,
                                      divisions: 82,
                                      inactiveColor: Colors.black,
                                      activeColor: Colors.black,
                                      values:
                                          RangeValues(_lowValue, _highValue),
                                      onChanged: (_range) {
                                        setState(() => {
                                              _lowValue = _range.start,
                                              _highValue = _range.end
                                            });
                                      },
                                    ),
                                  ],
                                )),
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      print('WHATTTTTTTTTT${user.uid}');
                                      // If the form is valid you can move on
                                      if (_formKey.currentState.validate()) {
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
                                        //write preference into db
                                        await DatabaseService(uid: user.uid)
                                            .updatePreference(
                                          _lowValue,
                                          _highValue,
                                          genderPreference,
                                        );

                                        Navigator.of(context)
                                            .pushNamed('/questions');
                                      }
                                    },
                                    textColor: Colors.white,
                                    color: Hexcolor("#8CC63E"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Row(
                                      children: <Widget>[
                                        Text('QUESTION TIME  ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Icon(MdiIcons.arrowRight, size: 18)
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
