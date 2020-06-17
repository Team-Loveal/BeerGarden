import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
                                  setState(() => furniture = val);
                                },
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Would you rather have a home in the beach or the mountains?',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              SizedBox(height: 20.0),
                              FlutterRadioButtonGroup(
                                items: [
                                  "🏖Beach",
                                  "🏔Mountains",
                                ],
                                onSelected: (val) {
                                  print(val);
                                  beachOrMountain = val;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  '🍱When you get take-out food do you eat out of the container or transfer the food to dishes?'),
                              SizedBox(height: 20.0),
                              FlutterRadioButtonGroup(
                                items: [
                                  "Eat out of the container",
                                  "Transfer the food",
                                ],
                                onSelected: (val) {
                                  takeOutFood = val;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  '🏝If you were deserted on an island what items would you bring with you?'),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => desertedIsland = val);
                                },
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  "💒If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?"),
                              SizedBox(height: 20.0),
                              FlutterRadioButtonGroup(
                                items: [
                                  "Glamorous wedding",
                                  "Small ceremony",
                                ],
                                onSelected: (val) {
                                  wedding = val;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text("🏡Your place or mine?"),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => yourPlaceOrMine = val);
                                },
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
                                      furniture ?? "",
                                      beachOrMountain ?? "",
                                      takeOutFood ?? "",
                                      desertedIsland ?? "",
                                      wedding ?? "",
                                      yourPlaceOrMine ?? ""
                                    );

                                    Navigator.of(context)
                                        .pushNamed('/myProfile');
                                  },
                                  textColor: Colors.white,
                                  color: Hexcolor("#8CC63E"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    children: <Widget>[
                                      //change to just upload photo?
                                      Text('Save your answers ',
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
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
