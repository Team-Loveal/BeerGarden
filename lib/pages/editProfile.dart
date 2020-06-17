import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map data = {};

  String nickname;
  String location;
  int age;
  String gender;
  String occupation;
  String about;

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

  //preferences
  double _lowValue = 20;
  double _highValue = 100;
  String genderPreference;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<User>(context);

    //Setting the default values
    yodeling = data['yodelingEdit'];
    shopping = data['shoppingEdit'];
    makingBalloonAnimals = data['makingBalloonAnimalsEdit'];
    cooking = data['cookingEdit'];
    painting = data['paintingEdit'];
    movies = data['moviesEdit'];
    sports = data['sportsEdit'];
    writing = data['writingEdit'];
    drinking = data['drinkingEdit'];

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Hexcolor("#8CC63E"),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
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
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(userData.imgUrl),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Edit Profile Picture',
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      textDirection: TextDirection.ltr,
                                      children: <Widget>[
                                        TextFormField(
                                          onChanged: (val) {
                                            if (val != userData.nickname) {
                                              setState(() => nickname = val);
                                            } else {
                                              nickname = data['nicknameEdit'];
                                            }
                                          },
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                          initialValue: data['nicknameEdit'],
                                          decoration: InputDecoration(
                                            labelText: 'Nickname',
                                          ),
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                        ),
                                        TextFormField(
                                          onChanged: (val) {
                                            if (val != userData.location) {
                                              setState(() => location = val);
                                            } else {
                                              location = userData.location;
                                            }
                                          },
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300),
                                          initialValue: data['locationEdit'],
                                          decoration: InputDecoration(
                                            labelText: 'Location',
                                          ),
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 70),
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Age',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      DropdownButton<int>(
                                                        value: age != null
                                                            ? age
                                                            : data['ageEdit'],
                                                        iconSize: 24,
                                                        onChanged:
                                                            (int newValue) {
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
                                                        ].map<
                                                            DropdownMenuItem<
                                                                int>>((int
                                                            value) {
                                                          return DropdownMenuItem<
                                                              int>(
                                                            value: value,
                                                            child: Text(value
                                                                .toString()),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Gender',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  DropdownButton<String>(
                                                    value: gender != null
                                                        ? gender
                                                        : data['genderEdit'],
                                                    iconSize: 24,
                                                    onChanged:
                                                        (String newValue) {
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
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val != userData.occupation) {
                                          setState(() => occupation = val);
                                        } else {
                                          occupation = userData.occupation;
                                        }
                                      },
                                      initialValue: data['occupationEdit'],
                                      decoration: InputDecoration(
                                          labelText: 'Enter your occupation'),
                                      keyboardType: TextInputType.text,
                                    ),
                                    TextFormField(
                                      onChanged: (val) {
                                        if (val != userData.about) {
                                          setState(() => about = val);
                                        } else {
                                          about = userData.about;
                                        }
                                      },
                                      initialValue: data['aboutEdit'],
                                      decoration: InputDecoration(
                                          labelText:
                                              'Share something about yourself'),
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
                                              selected: data['yodelingEdit'],
                                              onSelected: (isSelected) => {
                                                data['yodelingEdit'] =
                                                    !data['yodelingEdit'],
                                                setState(() => {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('shopping'),
                                              selected: data['shoppingEdit'],
                                              onSelected: (isSelected) => {
                                                data['shoppingEdit'] =
                                                    !data['shoppingEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text(
                                                  'making balloon animals'),
                                              selected: data[
                                                  'makingBalloonAnimalsEdit'],
                                              onSelected: (isSelected) => {
                                                data['makingBalloonAnimalsEdit'] =
                                                    !data[
                                                        'makingBalloonAnimalsEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('cooking'),
                                              selected: data['cookingEdit'],
                                              onSelected: (isSelected) => {
                                                data['cookingEdit'] =
                                                    !data['cookingEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('painting'),
                                              selected: data['paintingEdit'],
                                              onSelected: (isSelected) => {
                                                data['paintingEdit'] =
                                                    !data['paintingEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('writing'),
                                              selected: data['writingEdit'],
                                              onSelected: (isSelected) => {
                                                data['writingEdit'] =
                                                    !data['writingEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('sports'),
                                              selected: data['sportsEdit'],
                                              onSelected: (isSelected) => {
                                                data['sportsEdit'] =
                                                    !data['sportsEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('movies'),
                                              selected: data['moviesEdit'],
                                              onSelected: (isSelected) => {
                                                data['moviesEdit'] =
                                                    !data['moviesEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                            FilterChip(
                                              label: Text('drinking'),
                                              selected: data['drinkingEdit'],
                                              onSelected: (isSelected) => {
                                                data['drinkingEdit'] =
                                                    !data['drinkingEdit'],
                                                setState(() {})
                                              },
                                              selectedColor: Colors.pink[400],
                                              checkmarkColor: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Text(
                                        'Set Preferences',
                                        style: TextStyle(fontSize: 30.0),
                                      ),
                                    ),
                                    Text(
                                      "Show Me",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Center(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: genderPreference,
                                        iconSize: 24,
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
                                            child: Text(value,
                                                style:
                                                    TextStyle(fontSize: 20.0)),
                                          );
                                        }).toList(),
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
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Text(
                                                'Age Range',
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Text(
                                                '${_lowValue.toInt().toString()} - ${_highValue.toInt().toString()}',
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                            )
                                          ],
                                        ),
                                        RangeSlider(
                                          min: 20,
                                          max: 100,
                                          divisions: 80,
                                          inactiveColor: Colors.black,
                                          activeColor: Colors.black,
                                          values: RangeValues(
                                              _lowValue, _highValue),
                                          onChanged: (_range) {
                                            setState(() => {
                                                  _lowValue = _range.start,
                                                  _highValue = _range.end
                                                });
                                          },
                                        ),
                                      ],
                                    )),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: RaisedButton(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Colors.grey[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        color: Colors.pinkAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        onPressed: () async {
                                          await DatabaseService(uid: user.uid)
                                              .editUserData(
                                            nickname ?? userData.nickname,
                                            location ?? userData.location,
                                            age ?? userData.age,
                                            gender ?? userData.gender,
                                            occupation ?? userData.occupation,
                                            about ?? userData.about,
                                            yodeling ?? userData.yodeling,
                                            shopping ?? userData.shopping,
                                            makingBalloonAnimals ??
                                                userData.makingBalloonAnimals,
                                            cooking ?? userData.cooking,
                                            painting ?? userData.painting,
                                            movies ?? userData.movies,
                                            sports ?? userData.sports,
                                            writing ?? userData.writing,
                                            drinking ?? userData.drinking,
                                          );

                                          //write preference into db
                                          await DatabaseService(uid: user.uid)
                                              .updatePreference(
                                            _lowValue,
                                            _highValue,
                                            genderPreference,
                                          );

                                          Navigator.of(context)
                                              .pushNamed('/navigationHome');
                                          //  Navigator.pop(context);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
