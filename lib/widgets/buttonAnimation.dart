import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:provider/provider.dart';

class Box extends StatelessWidget {
  static final boxDecoration = BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 5,
            offset: Offset(0, 8),
            spreadRadius: 2)
      ]);

  @override
  Widget build(BuildContext context) {
    final myUserData = Provider.of<UserData>(context);
    final user = Provider.of<User>(context);

    return PlayAnimation<double>(
      duration: 400.milliseconds,
      tween: 0.0.tweenTo(80.0),
      builder: (context, child, height) {
        return PlayAnimation<double>(
          duration: 1200.milliseconds,
          delay: 500.milliseconds,
          tween: 2.0.tweenTo(300.0),
          builder: (context, child, width) {
            return InkWell(
              child: Container(
                decoration: boxDecoration,
                width: width,
                height: height,
                child: isEnoughRoomForTypewriter(width)
                    ? TypewriterText("Meet someone NEW ")
                    : Container(),
              ),
              onTap: () async {
                int matches = myUserData.matches + 1;
                await Firestore.instance
                    .collection("messages")
                    .where('matchedUsers', arrayContains: user.uid)
                    .getDocuments()
                    .then((data) => data.documents.forEach((doc) => {
                          if (!doc['matched'])
                            {
                              if (doc['fromID'] != user.uid)
                                {
                                  Firestore.instance
                                      .collection("messages")
                                      .document(doc.documentID)
                                      .updateData({
                                    'fromID': user.uid,
                                    'toID': doc['fromID']
                                  }),
                                  Firestore.instance
                                      .collection('users')
                                      .document(user.uid)
                                      .updateData({
                                    'matchID': doc['fromID'],
                                    'chatID': doc.documentID,
                                    'matches': matches,
                                    'confetti': true,
                                  })
                                }
                              else
                                {
                                  Firestore.instance
                                      .collection('users')
                                      .document(user.uid)
                                      .updateData({
                                    'matchID': doc['toID'],
                                    'chatID': doc.documentID,
                                    'matches': matches,
                                    'confetti': true,
                                  }),
                                }
                            }
                        }));
                Navigator.of(context).pushNamed('/navigationHome');
              },
            );
          },
        );
      },
    );
  }

  bool isEnoughRoomForTypewriter(double width) => width > 20;
}

class TypewriterText extends StatelessWidget {
  static const TEXT_STYLE = TextStyle(
    letterSpacing: 2,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final String text;

  TypewriterText(this.text);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<int>(
        duration: 800.milliseconds,
        delay: 800.milliseconds,
        tween: 0.tweenTo(text.length),
        builder: (context, child, textLength) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text.substring(0, textLength), style: TEXT_STYLE),
              _blinkingCursor()
            ],
          );
        });
  }

  Widget _blinkingCursor() {
    return LoopAnimation<int>(
      duration: 600.milliseconds,
      tween: 0.tweenTo(1),
      builder: (context, child, oneOrZero) {
        return Opacity(
            opacity: oneOrZero == 1 ? 1.0 : 0.0,
            child: Text("🍺", style: TEXT_STYLE));
      },
    );
  }
}
