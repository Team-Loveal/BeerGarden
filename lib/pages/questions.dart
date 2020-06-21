import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class Questions extends StatefulWidget {
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  String bed;
  String reviews;
  String foreverEat;
  String bestForLast;
  String aliens;

  //form global key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
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
                        Text(
                          'Questions',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                              "The more questions you answer about yourself, the more likely someone will buy you a drink🍺 You'll have a chance to answer more questions later too!"),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '🛌Do you make your bed in the morning?',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => bed = val);
                                },
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please fill out an answer';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  '🤓Do you read reviews, or just go with your gut?'),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => reviews = val);
                                },
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please fill out an answer';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  '🌮If you could only eat one thing for the rest of your life, what would it be?'),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => foreverEat = val);
                                },
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please fill out an answer';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  "🌭If you're eating a meal do you save the best thing for last or eat it first?"),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => bestForLast = val);
                                },
                                onSaved: (String value) {
                                  //this block is used to run code when a user save the form
                                },
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please fill out an answer';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              Text("👽Do you believe in aliens?"),
                              TextFormField(
                                cursorWidth: 3,
                                onChanged: (val) {
                                  setState(() => aliens = val);
                                },
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please fill out an answer';
                                  }
                                  return null;
                                },
                              ),
                              //BUTTON
                              Container(
                                padding: EdgeInsets.fromLTRB(30, 30, 20, 0),
                                child: RaisedButton(
                                  onPressed: () async {
                                    // If the form is valid you can move on
                                    if (_formKey.currentState.validate()) {
                                      //write answers into db
                                      await DatabaseService(uid: user.uid)
                                          .updateAnswers(
                                        bed ?? "",
                                        reviews ?? "",
                                        foreverEat ?? "",
                                        bestForLast ?? "",
                                        aliens ?? "",
                                      );

                                      //route to upload photo page
                                      Navigator.of(context)
                                          .pushNamed('/uploadphoto');
                                    }
                                  },
                                  textColor: Colors.white,
                                  color: Hexcolor("#8CC63E"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    children: <Widget>[
                                      //change to just upload photo?
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
