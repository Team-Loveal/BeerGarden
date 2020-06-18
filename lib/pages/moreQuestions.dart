import 'package:cloud_firestore/cloud_firestore.dart';
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
  Map doc = {};

  String furniture;
  String beachOrMountain;
  String takeOutFood;
  String desertedIsland;
  String wedding;
  String yourPlaceOrMine;

//  @override
//  void initState() {
//    super.initState();
//    final user = Provider.of<User>(context);
//
//    Firestore.instance.collection('users').document(user.uid).get().then((doc) {
//      //get values for the widget build
//      setState(() {
//        //furniture = doc['furniture'];
//        beachOrMountain = doc['beachOrMountain'];
//        takeOutFood = doc['takeOutFood'];
//        //desertedIsland = doc['desertedIsland'];
//        wedding = doc['wedding'];
//        yourPlaceOrMine = doc['yourPlaceOrMine'];
//      });
//    });
//  }


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

    //Set the default values
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
                                    if (val != doc['furniture']) {
                                      setState(() => doc['furniture'] = val);
                                    } else {
                                      doc['furniture'] = doc['furniture'];
                                    }
                                  },
                                  initialValue: doc['furniture'],
                                  autofocus: true,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'Would you rather have a home in the beach or the mountains?',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                            RadioListTile(
                                  title: const Text('🏖Beach'),
                                    value:'🏖Beach',
                                    groupValue: beachOrMountain,
                                    onChanged: (val) {
                                      doc['beachOrMountain'] = val;
                                      setState(() {
                                      });
                                    },
                                  ),
                                RadioListTile(
                                  title: const Text('🏔Mountains'),
                                  value: '🏔Mountains',
                                  groupValue: beachOrMountain,
                                  onChanged: (val) {
                                    doc['beachOrMountain'] = val;
                                    setState(() {
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(height: 20.0),
                                Text(
                                    '🍱When you get take-out food do you eat out of the container or transfer the food to dishes?'),
                                SizedBox(height: 20.0),
                                RadioListTile(
                                  title: const Text('Eat out of the container'),
                                  value:'Eat out of the container',
                                  groupValue: takeOutFood,
                                  onChanged: (val) {
                                    doc['takeOutFood'] = val;
                                    setState(() {
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: const Text('Transfer the food'),
                                  value: 'Transfer the food',
                                  groupValue: takeOutFood,
                                  onChanged: (val) {
                                    doc['takeOutFood'] = val;
                                    setState(() {
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                    '🏝If you were deserted on an island what items would you bring with you?'),
                                TextFormField(
                                  cursorWidth: 3,
                                  onChanged: (val) {
                                    if (val != doc['desertedIsland']) {
                                      setState(() => doc['desertedIsland'] = val);
                                    } else {
                                      doc['desertedIsland'] = doc['desertedIsland'];
                                    }
                                  },
                                  initialValue: doc['desertedIsland'],
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                    "💒If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?"),
                                SizedBox(height: 20.0),
                                RadioListTile(
                                  title: const Text('Glamorous wedding'),
                                  value:'Glamorous wedding',
                                  groupValue: wedding,
                                  onChanged: (val) {
                                    doc['wedding'] = val;
                                    setState(() {
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: const Text('Small ceremony'),
                                  value: 'Small ceremony',
                                  groupValue: wedding,
                                  onChanged: (val) {
                                    doc['wedding'] = val;
                                    setState(() {
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                Text("🏡Your place or mine?"),
                                TextFormField(
                                  cursorWidth: 3,
                                  onChanged: (val) {
                                    if (val != doc['yourPlaceOrMine']) {
                                      setState(() => doc['yourPlaceOrMine'] = val);
                                    } else {
                                      doc['yourPlaceOrMine'] = doc['yourPlaceOrMine'];
                                    }
                                  },
                                  initialValue: doc['yourPlaceOrMine'],
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
                                          doc['furniture'] ?? "",
                                          doc['beachOrMountain'] ?? "",
                                          doc['takeOutFood'] ?? "",
                                          doc['desertedIsland'] ?? "",
                                          doc['wedding'] ?? "",
                                          doc['yourPlaceOrMine'] ?? ""
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