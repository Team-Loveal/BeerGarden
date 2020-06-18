import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MoreQuestions extends StatefulWidget {
  @override
  _MoreQuestionsState createState() => _MoreQuestionsState();
}

class _MoreQuestionsState extends State<MoreQuestions> {
  String furniture;
  String beachOrMountain;
  String takeOutFood;
  String desertedIsland;
  String wedding;
  String yourPlaceOrMine;

  multipleChoice1 _multipleChoice1 = multipleChoice1.beach;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
    if (snapshot.hasData) {
      UserData userData = snapshot.data;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Hexcolor("#8CC63E"),
          title: Text(
            'Questions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Hexcolor("#FFF6C2"),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
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
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                                "Answer some more questions about yourself. The more information you provide, the more likely someone will chat you up!"),
                          ),
                          FormBuilder(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '🚽If you were a piece of furniture, what piece of furniture would you be?',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                TextFormField(
                                  cursorWidth: 3,
                                  onChanged: (val) {
                                    if (val != userData.furniture) {
                                      setState(() => furniture = val);
                                    } else {
                                      furniture = userData.furniture;
                                    }
                                  },
                                  initialValue: userData.furniture,
                                  autofocus: true,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'Would you rather have a home in the beach or the mountains?',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                ListTile(
                                  title: const Text('🏖Beach'),
                                  selected: true,
                                  //selected: _multipleChoice1 == multipleChoice1.beach,
                                  leading: Radio(
                                    value: '🏖Beach',
                                    groupValue: beachOrMountain,
                                    onChanged: (val) {
                                      setState(() {
                                        beachOrMountain = val;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('🏔Mountains'),
                                  selected: false,
                                  leading: Radio(
                                    value: '🏔Mountains',
                                    groupValue: beachOrMountain,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        beachOrMountain = val;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(height: 20.0),
                                Text(
                                    '🍱When you get take-out food do you eat out of the container or transfer the food to dishes?'),
                                SizedBox(height: 20.0),
                                ListTile(
                                  title: const Text('Eat out of the container'),
                                  leading: Radio(
                                    value: 'Eat out of the container',
                                    groupValue: takeOutFood,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        takeOutFood = val;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("Transfer the food"),
                                  leading: Radio(
                                    value: "Transfer the food",
                                    groupValue: takeOutFood,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        takeOutFood = val;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                    '🏝If you were deserted on an island what items would you bring with you?'),
                                TextFormField(
                                  cursorWidth: 3,
                                  onChanged: (val) {
                                    if (val != userData.desertedIsland) {
                                      setState(() => desertedIsland = val);
                                    } else {
                                      desertedIsland = userData.desertedIsland;
                                    }
                                  },
                                  initialValue: userData.desertedIsland,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                    "💒If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?"),
                                SizedBox(height: 20.0),
                                ListTile(
                                  title: const Text('Glamorous wedding'),
                                  leading: Radio(
                                    value: 'Glamorous wedding',
                                    groupValue: wedding,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        wedding = val;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text("Small ceremony"),
                                  leading: Radio(
                                    value: "Small ceremony",
                                    groupValue: wedding,
                                    onChanged: (val) {
                                      setState(() {
                                        print(val);
                                        wedding = val;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Text("🏡Your place or mine?"),
                                TextFormField(
                                  cursorWidth: 3,
                                  onChanged: (val) {
                                    if (val != userData.yourPlaceOrMine) {
                                      setState(() => yourPlaceOrMine = val);
                                    } else {
                                      yourPlaceOrMine = userData.yourPlaceOrMine;
                                    }
                                  },
                                  initialValue: userData.yourPlaceOrMine,
                                  keyboardType: TextInputType.text,
                                ),
                                //BUTTON
                                Container(
                                  padding: EdgeInsets.fromLTRB(30, 30, 20, 0),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      //write answers into db
                                      await DatabaseService(uid: user.uid)
                                          .updateMoreAnswers(
                                          furniture ?? userData.furniture,
                                          beachOrMountain ?? "",
                                          takeOutFood ?? "",
                                          desertedIsland ?? userData.desertedIsland,
                                          wedding ?? "",
                                          yourPlaceOrMine ?? userData.yourPlaceOrMine
                                      );

                                      Navigator.of(context)
                                          .pushNamed('/navigationHome');
                                    },
                                    textColor: Colors.white,
                                    color: Hexcolor("#8CC63E"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50)),
                                    child: Row(
                                      children: <Widget>[
                                        //change to just upload photo?
                                        Text('Save your answers ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Icon(MdiIcons.arrowRight, size: 18)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
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

enum multipleChoice1 {
  beach, mountain
}
