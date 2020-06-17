import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

// unmatch user
void unmatch(chatRoomID, matchID, matchName) async {
  DocumentReference docRef =
      Firestore.instance.collection('messages').document(chatRoomID);
  docRef
      .updateData({
        'matchedUsers': [matchID, ""]
      })
      .then((data) =>
          Fluttertoast.showToast(msg: 'You Unmatched with $matchName'))
      .catchError((err) => print("Unmatching Unsuccessful: $err"));
}

// warn user before unmatch
showAlertDialog(BuildContext context, chatRoomID, matchID, matchName) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel",
        style:
            TextStyle(color: Hexcolor("#F4AA33"), fontWeight: FontWeight.bold)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes",
        style:
            TextStyle(color: Hexcolor("#F4AA33"), fontWeight: FontWeight.bold)),
    onPressed: () {
      unmatch(chatRoomID, matchID, matchName);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    title: Text("Are you sure?"),
    content: Text(
        "Once unmatched, you will not recieve further messages from the user."),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
