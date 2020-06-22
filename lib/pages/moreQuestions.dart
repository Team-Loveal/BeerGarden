import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'navigationHome.dart';

class MoreQuestions extends StatefulWidget {
  @override
  _MoreQuestionsState createState() => _MoreQuestionsState();
}

class _MoreQuestionsState extends State<MoreQuestions> {
  Map doc = {};
  String furniture;
  String beachOrMountain;
  String takeOutFood;
  String desertedIsland;
  String wedding;
  String yourPlaceOrMine;
  String bed;
  String reviews;
  String foreverEat;
  String bestForLast;
  String aliens;

  //for back to MyProfile()
  int profileIndex = 2;

  @override
  Widget build(BuildContext context) {
    doc = ModalRoute.of(context).settings.arguments;
    final user = Provider.of<User>(context);

    //Setting the default values
    furniture = doc['furniture'];
    beachOrMountain = doc['beachOrMountain'];
    takeOutFood = doc['takeOutFood'];
    desertedIsland = doc['desertedIsland'];
    wedding = doc['wedding'];
    yourPlaceOrMine = doc['yourPlaceOrMine'];
    bed = doc['bed'];
    reviews = doc['reviews'];
    foreverEat = doc['foreverEat'];
    bestForLast = doc['bestForLast'];
    aliens = doc['aliens'];

    void saveAnswers(User user) async {
      //write answers into db
      await DatabaseService(uid: user.uid).updateMoreAnswers(
          doc['furniture'] ?? "",
          doc['beachOrMountain'] ?? "",
          doc['takeOutFood'] ?? "",
          doc['desertedIsland'] ?? "",
          doc['wedding'] ?? "",
          doc['yourPlaceOrMine'] ?? "");

      await DatabaseService(uid: user.uid).updateAnswers(
          doc['bed'] ?? "",
          doc['reviews'] ?? "",
          doc['foreverEat'] ?? "",
          doc['bestForLast'] ?? "",
          doc['aliens'] ?? "");
    }

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
          title: Text('Questions',
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
                saveAnswers(user);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NavigationHome(newIdx: profileIndex)));
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
                            children: <Widget>[
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
                              GestureDetector(
                                onTap: () => FocusScope.of(context).unfocus(),
                                child: SingleChildScrollView(
                                  child: Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30),
                                            child: Text(
                                                "Answer some more questions about yourself or edit your answers. The more information you provide, the more likely someone will chat you up!"),
                                          ),
                                          FormBuilder(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(height: 20.0),
                                                Text(
                                                  "🚽 If you were a piece of furniture, what piece of furniture would you be?",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val !=
                                                        doc['furniture']) {
                                                      setState(() =>
                                                          doc['furniture'] =
                                                              val);
                                                    } else {
                                                      doc['furniture'] =
                                                          doc['furniture'];
                                                    }
                                                  },
                                                  initialValue:
                                                      doc['furniture'],
                                                  autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  'Would you rather have a home in the beach or the mountains?',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                RadioListTile(
                                                  title: const Text('🏖 Beach'),
                                                  value: '🏖 Beach',
                                                  groupValue: beachOrMountain,
                                                  onChanged: (val) {
                                                    doc['beachOrMountain'] =
                                                        val;
                                                    setState(() {});
                                                  },
                                                ),
                                                RadioListTile(
                                                  title: const Text(
                                                      '🏔 Mountains'),
                                                  value: '🏔 Mountains',
                                                  groupValue: beachOrMountain,
                                                  onChanged: (val) {
                                                    doc['beachOrMountain'] =
                                                        val;
                                                    setState(() {});
                                                  },
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  '🍱 When you get take-out food do you eat out of the container or transfer the food to dishes?',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 30.0),
                                                RadioListTile(
                                                  title: const Text(
                                                      'Eat out of the container'),
                                                  value:
                                                      'Eat out of the container',
                                                  groupValue: takeOutFood,
                                                  onChanged: (val) {
                                                    doc['takeOutFood'] = val;
                                                    setState(() {});
                                                  },
                                                ),
                                                RadioListTile(
                                                  title: const Text(
                                                      'Transfer the food'),
                                                  value: 'Transfer the food',
                                                  groupValue: takeOutFood,
                                                  onChanged: (val) {
                                                    doc['takeOutFood'] = val;
                                                    setState(() {});
                                                  },
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  '🏝 If you were deserted on an island what items would you bring with you?',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val !=
                                                        doc['desertedIsland']) {
                                                      setState(() =>
                                                          doc['desertedIsland'] =
                                                              val);
                                                    } else {
                                                      doc['desertedIsland'] =
                                                          doc['desertedIsland'];
                                                    }
                                                  },
                                                  initialValue:
                                                      doc['desertedIsland'],
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  "💒 If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 30.0),
                                                RadioListTile(
                                                  title: const Text(
                                                      'Glamorous wedding'),
                                                  value: 'Glamorous wedding',
                                                  groupValue: wedding,
                                                  onChanged: (val) {
                                                    doc['wedding'] = val;
                                                    setState(() {});
                                                  },
                                                ),
                                                RadioListTile(
                                                  title: const Text(
                                                      'Small ceremony'),
                                                  value: 'Small ceremony',
                                                  groupValue: wedding,
                                                  onChanged: (val) {
                                                    doc['wedding'] = val;
                                                    setState(() {});
                                                  },
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  "🏡 Your place or mine?",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val !=
                                                        doc['yourPlaceOrMine']) {
                                                      setState(() =>
                                                          doc['yourPlaceOrMine'] =
                                                              val);
                                                    } else {
                                                      doc['yourPlaceOrMine'] =
                                                          doc['yourPlaceOrMine'];
                                                    }
                                                  },
                                                  initialValue:
                                                      doc['yourPlaceOrMine'],
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                    '🛌 Do you make your bed in the morning? ',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val != doc['bed']) {
                                                      setState(() =>
                                                          doc['bed'] = val);
                                                    } else {
                                                      doc['bed'] = doc['bed'];
                                                    }
                                                  },
                                                  initialValue: doc['bed'],
                                                  autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                    '🤓 Do you read reviews, or just go with your gut?',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val != doc['reviews']) {
                                                      setState(() =>
                                                          doc['reviews'] = val);
                                                    } else {
                                                      doc['reviews'] =
                                                          doc['reviews'];
                                                    }
                                                  },
                                                  initialValue: doc['reviews'],
                                                  autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  '🌮 If you could only eat one thing for the rest of your life, what would it be?',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val !=
                                                        doc['foreverEat']) {
                                                      setState(() =>
                                                          doc['foreverEat'] =
                                                              val);
                                                    } else {
                                                      doc['foreverEat'] =
                                                          doc['foreverEat'];
                                                    }
                                                  },
                                                  initialValue:
                                                      doc['foreverEat'],
                                                  autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  "🌭 If you're eating a meal do you save the best thing for last or eat it first?",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val !=
                                                        doc['bestForLast']) {
                                                      setState(() =>
                                                          doc['bestForLast'] =
                                                              val);
                                                    } else {
                                                      doc['bestForLast'] =
                                                          doc['bestForLast'];
                                                    }
                                                  },
                                                  initialValue:
                                                      doc['bestForLast'],
                                                  autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                                SizedBox(height: 30.0),
                                                Text(
                                                  '👽 Do you believe in aliens?',
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  cursorWidth: 3,
                                                  onChanged: (val) {
                                                    if (val != doc['aliens']) {
                                                      setState(() =>
                                                          doc['aliens'] = val);
                                                    } else {
                                                      doc['aliens'] =
                                                          doc['aliens'];
                                                    }
                                                  },
                                                  initialValue: doc['aliens'],
                                                  autofocus: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
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
  }
}
