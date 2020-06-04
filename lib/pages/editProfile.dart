import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  String age = '20 - 29';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('images/blank.jpg'),
                      backgroundColor: Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        TextField(
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            labelText: 'Nickname',
                          ),
                          autofocus: true,
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w300),
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
//                          Container(
//                            child: DropdownButton<String>(
////                              items: 'one',
//                            ),
//                          ),
                            Padding(
                              padding: EdgeInsets.only(right: 70),
                              child: Text(
                                'Age',
                                style: TextStyle(
                                  color: Colors.orange[200],
                                  fontSize: 20,
                                ),
                              ),
                            ),
//                            Container(
////                              child: DropdownButton<String>(
////                                value: chosenValue,
////                                items: <String>['Male', 'Female', 'Other'],
////                              ),
//                            )
                            Text(
                              'Gender',
                              style: TextStyle(
                                color: Colors.orange[200],
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () => {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
