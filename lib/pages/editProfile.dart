import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:page_transition/page_transition.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  var ageList = new List<int>.generate(80, (i) => i + 1);
  String genderPreference;
  double _lowValue = 18;
  double _highValue = 80;

  //for back to MyProfile()
  int profileIndex = 2;

  void onSave(User user, UserData userData) async {
    await DatabaseService(uid: user.uid).editUserData(
      nickname ?? userData.nickname,
      location ?? userData.location,
      age ?? userData.age,
      gender ?? userData.gender,
      occupation ?? userData.occupation,
      about ?? userData.about,
      yodeling ?? userData.yodeling,
      shopping ?? userData.shopping,
      makingBalloonAnimals ?? userData.makingBalloonAnimals,
      cooking ?? userData.cooking,
      painting ?? userData.painting,
      movies ?? userData.movies,
      sports ?? userData.sports,
      writing ?? userData.writing,
      drinking ?? userData.drinking,
    );

    //write preference into db
    await DatabaseService(uid: user.uid).updatePreference(
        _lowValue ?? userData.lowAge,
        _highValue ?? userData.highAge,
        genderPreference ?? userData.genderPreference);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NavigationHome(newIdx: profileIndex)));
  }

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
              backgroundColor: Hexcolor("#8CC63E"),
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
                child: AppBar(
                  backgroundColor: Hexcolor("#8CC63E"),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.scale,
                              child: NavigationHome(newIdx: profileIndex)),
                        );
                      },
                      icon: Icon(MdiIcons.arrowLeft)),
                  title: Text('Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      )),
                  elevation: 0.0,
                  centerTitle: true,
                  actions: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      child: Text(
                        "save",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () async {
                        onSave(user, userData);
                      },
                    ),
                  ],
                ),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                child: SafeArea(
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
                                              Colors.white,
                                              Hexcolor('#FFF1BA'),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/editphoto');
                                                      },
                                                      child: Stack(
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            radius: 70,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    userData
                                                                        .imgUrl),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            right: 0,
                                                            child: Container(
                                                              height: 30.0,
                                                              width: 30.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Hexcolor(
                                                                    "#8CC63E"),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black26,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            2),
                                                                    blurRadius:
                                                                        6.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Icon(
                                                                MdiIcons.pencil,
                                                                size: 20.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        children: <Widget>[
                                                          TextFormField(
                                                            onChanged: (val) {
                                                              if (val !=
                                                                  userData
                                                                      .nickname) {
                                                                setState(() =>
                                                                    nickname =
                                                                        val);
                                                              } else {
                                                                nickname = data[
                                                                    'nicknameEdit'];
                                                              }
                                                            },
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                            initialValue: data[
                                                                'nicknameEdit'],
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Nickname',
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                          ),
                                                          SizedBox(
                                                              height: 10.0),
                                                          TextFormField(
                                                            onChanged: (val) {
                                                              if (val !=
                                                                  userData
                                                                      .location) {
                                                                setState(() =>
                                                                    location =
                                                                        val);
                                                              } else {
                                                                location =
                                                                    userData
                                                                        .location;
                                                              }
                                                            },
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300),
                                                            initialValue: data[
                                                                'locationEdit'],
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Location',
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                        child: Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              70),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          'Age',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                        DropdownButton<
                                                                            int>(
                                                                          value: age != null
                                                                              ? age
                                                                              : data['ageEdit'],
                                                                          iconSize:
                                                                              24,
                                                                          onChanged:
                                                                              (int newValue) {
                                                                            setState(() {
                                                                              age = newValue;
                                                                            });
                                                                          },
                                                                          items:
                                                                              ageList.map<DropdownMenuItem<int>>((int value) {
                                                                            return DropdownMenuItem<int>(
                                                                              value: value,
                                                                              child: Text(value.toString()),
                                                                            );
                                                                          }).toList(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                              Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      'Gender',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                    DropdownButton<
                                                                        String>(
                                                                      value: gender !=
                                                                              null
                                                                          ? gender
                                                                          : data[
                                                                              'genderEdit'],
                                                                      iconSize:
                                                                          24,
                                                                      onChanged:
                                                                          (String
                                                                              newValue) {
                                                                        setState(
                                                                            () {
                                                                          gender =
                                                                              newValue;
                                                                        });
                                                                      },
                                                                      items: <
                                                                          String>[
                                                                        'Female',
                                                                        'Male',
                                                                        'Rather not say'
                                                                      ].map<
                                                                          DropdownMenuItem<
                                                                              String>>((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child:
                                                                              Text(value),
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
                                                          if (val !=
                                                              userData
                                                                  .occupation) {
                                                            setState(() =>
                                                                occupation =
                                                                    val);
                                                          } else {
                                                            occupation =
                                                                userData
                                                                    .occupation;
                                                          }
                                                        },
                                                        initialValue: data[
                                                            'occupationEdit'],
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    'Occupation'),
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(height: 10.0),
                                                      TextFormField(
                                                        onChanged: (val) {
                                                          if (val !=
                                                              userData.about) {
                                                            setState(() =>
                                                                about = val);
                                                          } else {
                                                            about =
                                                                userData.about;
                                                          }
                                                        },
                                                        initialValue:
                                                            data['aboutEdit'],
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    'Bio'),
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                      SizedBox(height: 30.0),
                                                      Text('Interests',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300)),
                                                      SizedBox(height: 10.0),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Container(
                                                          child: Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            spacing: 5,
                                                            runSpacing: 3,
                                                            children: <Widget>[
                                                              FilterChip(
                                                                label: Text(
                                                                    'yodeling'),
                                                                selected: data[
                                                                    'yodelingEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['yodelingEdit'] =
                                                                      !data[
                                                                          'yodelingEdit'],
                                                                  setState(
                                                                      () => {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'shopping'),
                                                                selected: data[
                                                                    'shoppingEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['shoppingEdit'] =
                                                                      !data[
                                                                          'shoppingEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'making balloon animals'),
                                                                selected: data[
                                                                    'makingBalloonAnimalsEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['makingBalloonAnimalsEdit'] =
                                                                      !data[
                                                                          'makingBalloonAnimalsEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'cooking'),
                                                                selected: data[
                                                                    'cookingEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['cookingEdit'] =
                                                                      !data[
                                                                          'cookingEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'painting'),
                                                                selected: data[
                                                                    'paintingEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['paintingEdit'] =
                                                                      !data[
                                                                          'paintingEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'writing'),
                                                                selected: data[
                                                                    'writingEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['writingEdit'] =
                                                                      !data[
                                                                          'writingEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'sports'),
                                                                selected: data[
                                                                    'sportsEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['sportsEdit'] =
                                                                      !data[
                                                                          'sportsEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'movies'),
                                                                selected: data[
                                                                    'moviesEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['moviesEdit'] =
                                                                      !data[
                                                                          'moviesEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                              FilterChip(
                                                                label: Text(
                                                                    'drinking'),
                                                                selected: data[
                                                                    'drinkingEdit'],
                                                                onSelected:
                                                                    (isSelected) =>
                                                                        {
                                                                  data['drinkingEdit'] =
                                                                      !data[
                                                                          'drinkingEdit'],
                                                                  setState(
                                                                      () {})
                                                                },
                                                                selectedColor:
                                                                    Hexcolor(
                                                                        "#8CC63E"),
                                                                checkmarkColor:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(30.0),
                                                        child: Text(
                                                          'Set Preferences',
                                                          style: TextStyle(
                                                              fontSize: 30.0),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Gender",
                                                        style: TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                      Center(
                                                        child: DropdownButton<
                                                            String>(
                                                          isExpanded: true,
                                                          value: genderPreference !=
                                                                  null
                                                              ? genderPreference
                                                              : userData
                                                                  .genderPreference,
                                                          iconSize: 24,
                                                          onChanged: (String
                                                              newValue) {
                                                            setState(() {
                                                              genderPreference =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: <String>[
                                                            'Female',
                                                            'Male',
                                                            'Everyone'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(value,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0)),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                      Container(
                                                          child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        30.0),
                                                                child: Text(
                                                                  'Age',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        30.0),
                                                                child: Text(
                                                                  //'18 - 100',
                                                                  '${_lowValue.toInt()} - ${_highValue.toInt()}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20.0),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SliderTheme(
                                                            data:
                                                                SliderTheme.of(
                                                                        context)
                                                                    .copyWith(
                                                              overlayColor:
                                                                  Colors.white,
                                                              activeTrackColor:
                                                                  Hexcolor(
                                                                      "#8CC63E"),
                                                              inactiveTrackColor:
                                                                  Hexcolor(
                                                                      '#FFF1BA'),
                                                              thumbColor:
                                                                  Hexcolor(
                                                                      "#8CC63E"),
                                                              valueIndicatorColor:
                                                                  Hexcolor(
                                                                      "#8CC63E"),
                                                            ),
                                                            child:
                                                                frs.RangeSlider(
                                                              min: 18,
                                                              max: 100,
                                                              lowerValue:
                                                                  _lowValue,
                                                              upperValue:
                                                                  _highValue,
                                                              divisions: 82,
                                                              showValueIndicator:
                                                                  true,
                                                              valueIndicatorMaxDecimals:
                                                                  0,
                                                              onChanged: (double
                                                                      newLowerValue,
                                                                  double
                                                                      newUpperValue) {
                                                                setState(() {
                                                                  _lowValue =
                                                                      newLowerValue;
                                                                  _highValue =
                                                                      newUpperValue;
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
