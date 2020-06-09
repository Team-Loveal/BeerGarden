import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/services/database.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String age = '20 - 29';
  String gender = 'Female';

  updateProfileData(){

  }


  @override
  Widget build(BuildContext context) {

    //final userData = Provider.of<UserData>(context);
    return Scaffold(

      appBar: AppBar(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Padding(
                                  padding: EdgeInsets.only(right: 70),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        DropdownButton<String>(
                                          value: age,
                                          iconSize: 24,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              age = newValue;
                                            });
                                          },
                                          items: <String>[
                                            '20 - 29',
                                            '30 - 39',
                                            '40 - 49',
                                            '50 - 59',
                                            '60 - 69'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: gender,
                                      iconSize: 24,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          gender = newValue;
                                        });
                                      },
                                      items: <String>['Female', 'Male', 'Other']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
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
                              borderRadius: BorderRadius.circular(20)),
                            //final userData = Provider.of<UserData>(context);
                          onPressed: () => {
                          //  print(userData),
                            print("Datttttttaaatatatatataatatatatatatat"),
                            updateProfileData(),
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
    );
  }
}
