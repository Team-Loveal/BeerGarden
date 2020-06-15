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
  //TODO get rid of limit for answer fields
  //TODO answer fields conflict with question field when question is long
  //TODO add ability to edit answers to edit profile

  String bed;
  String reviews;
  String foreverEat;
  String bestForLast;
  String aliens;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Answer some questions about yourself',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ), //
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
                        Text("The more questions you answer about yourself, the more likely someone will buy you a drink🍺 You'll have a chance to answer more questions in the future too!"),
                        TextFormField(
                          cursorWidth: 3,
                          maxLength: 20,
                          onChanged: (val) {
                            setState(() => bed = val);
                          },
                          onSaved: (String value) {
                            //this block is used to run code when a user save the form
                          },
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              labelText: 'Do you make your bed in the morning?'),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          cursorWidth: 3,
                          maxLength: 20,
                          onChanged: (val) {
                            setState(() => reviews = val);
                          },
                          onSaved: (String value) {
                            //this block is used to run code when a user save the form
                          },
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              labelText: 'Do you read reviews, or just go with your gut?'),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          cursorWidth: 3,
                          maxLength: 20,
                          onChanged: (val) {
                            setState(() => foreverEat = val);
                          },
                          onSaved: (String value) {
                            //this block is used to run code when a user save the form
                          },
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              labelText: 'If you could only eat one thing for the rest of \n your life, what would it be?'),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          cursorWidth: 3,
                          maxLength: 20,

                          onChanged: (val) {
                            setState(() => bestForLast = val);
                          },
                          onSaved: (String value) {
                            //this block is used to run code when a user save the form
                          },
                          decoration: InputDecoration(

                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),

                              labelText: "If you're eating a meal do you save the best \nthing for last or eat it first?"),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          cursorWidth: 3,
                          maxLength: 20,
                          onChanged: (val) {
                            setState(() => aliens = val);
                          },
                          onSaved: (String value) {
                            //this block is used to run code when a user save the form
                          },
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              labelText: 'Do you believe in aliens?'),
                          keyboardType: TextInputType.text,
                        ),
                        //BUTTON
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                          child: RaisedButton(
                            onPressed: () async {

                              //write answers into db
                              await DatabaseService(uid: user.uid)
                                  .updateAnswers(
                                bed ?? "",
                                reviews ?? "",
                                foreverEat ?? "" ,
                                bestForLast ?? "",
                                  aliens ?? "",
                              );

                              Navigator.of(context)
                                  .pushNamed('/uploadphoto');
                            },
                            textColor: Colors.white,
                            color: Hexcolor("#215a00"),
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
