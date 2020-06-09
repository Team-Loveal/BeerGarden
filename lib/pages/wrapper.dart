import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/pages/welcome.dart';
import 'package:lovealapp/pages/match.dart';
import 'package:provider/provider.dart';
import 'package:lovealapp/pages/navigationHome.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//listen for auth changes provided by stream declared in auth.dart
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //receive user from provider stream
    final user = Provider.of<User>(context);

    if (user == null) {
      return Welcome();
    } else {
      //get potential matches for the user
      Firestore.instance
          .collection("users")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((document) {
          if (document.documentID != user.uid) {
            //concat and make into a string and push into chatIds array
            String toID = document.documentID;
            String chatId1 = '${user.uid} - ${document.documentID}';
            String chatId2 = '${document.documentID} - ${user.uid}';

            //if it doesn't exist then write
            Firestore.instance
                .collection("messages")
                .getDocuments()
                .then((querySnapshot) {
              querySnapshot.documents.forEach((document) {
                if (chatId1 != document.documentID &&
                    chatId2 != document.documentID) {
                  //can you create a document without creating a field?
                  Firestore.instance
                      .collection("messages")
                      .document(chatId1)
                      .setData({
                    'fromID': user.uid,
                    'toID': toID,
                    'chatted': false,
                  });
                }
              });
            });
          }
        });
      });

      return NavigationHome();
    }
  }
}
