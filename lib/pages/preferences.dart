import 'package:flutter/material.dart';

class SetPreferences extends StatefulWidget {
  @override
  _SetPreferencesState createState() => _SetPreferencesState();
}

class _SetPreferencesState extends State<SetPreferences> {
  double _lowValue = 18;
  double _highValue = 100;
  String genderPreference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Set Preferences',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ), //
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              "Show Me", style:TextStyle(fontSize: 20.0),
            ),
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
              items: <String>['Women', 'Men', 'Everyone']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style:TextStyle(fontSize: 20.0)),
                );
              }).toList(),
            ),
          ),
          Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text('Age Range',style:TextStyle(fontSize: 20.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text('${_lowValue.toInt().toString()} - ${_highValue.toInt().toString()}', style:TextStyle(fontSize: 20.0),),
                      )
                    ],
                  ),
                  RangeSlider(
                    min: 18,
                    max: 100,
                    divisions: 82,
                    inactiveColor: Colors.orange,
                    activeColor: Colors.orange,
                    values: RangeValues(_lowValue, _highValue),
                    onChanged: (_range) {
                      setState(() =>
                      {_lowValue = _range.start, _highValue = _range.end});
                    },
                  ),
                ],
              )
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
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: ()  {
              },
            ),
          )
        ],
      ),
    );
  }
}
