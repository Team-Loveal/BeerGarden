import 'package:flutter/material.dart';
import 'package:lovealapp/models/user.dart';
import 'package:lovealapp/services/database.dart';
import 'package:lovealapp/shared/loading.dart';
import 'package:lovealapp/widgets/buttonAnimation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'message.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lovealapp/widgets/interests.dart';
import 'package:lovealapp/widgets/questionAnswer.dart';
import 'package:lovealapp/widgets/fullScreenImage.dart';
import 'package:pimp_my_button/pimp_my_button.dart';
import 'package:confetti/confetti.dart';

//adding for transition animation
import 'package:page_transition/page_transition.dart';

class Match extends StatefulWidget {
  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  String matchID;
  String chatID;
  int matches;
  bool isProfileCreated;
  bool limitBlur;
  double lowAge;
  double highAge;
  String genderPreference;
  bool playConfetti;

  double sigmaX = 50;
  double sigmaY = 50;

  ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<User>(context, listen: false);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));

    Firestore.instance.collection('users').document(user.uid).get().then((doc) {
      //get values for the widget build
      setState(() {
        matchID = doc['matchID'];
        chatID = doc['chatID'];
        matches = doc['matches'];
        limitBlur = doc['limitBlur'];
        lowAge = doc['lowAge'].toDouble();
        highAge = doc['highAge'].toDouble();
        genderPreference = doc['genderPreference'];
        playConfetti = doc['confetti'];
      });

      //decrease blur of active messages if matches have been reset to zero and you are not a new user
      if (doc['matches'] == 0 && doc['matchID'] != null && !doc['limitBlur']) {
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .updateData({'limitBlur': true});

        Firestore.instance
            .collection("messages")
            .where('fromID', isEqualTo: user.uid)
            .where('matched', isEqualTo: true)
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((document) {
            var documentID = document.documentID;
            var blur = document.data['blur'] - 5;

            //for each message document update the blur value
            Firestore.instance
                .collection("messages")
                .document(documentID)
                .updateData({'blur': blur});
          });
        });
      }
    });
  }

  _confettiOff() async {
    final user = Provider.of<User>(context, listen: false);
    Firestore.instance.collection('users').document(user.uid).updateData({
      'confetti': false,
    });
  }

  startChat() async {
    Firestore.instance
        .collection("messages")
        .document(chatID)
        .updateData({'matched': true});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: matchID).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData && matches > 0) {
            if (playConfetti) {
              _confettiController.play();
              _confettiOff();
            }
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
                stops: [0.01, 0.2],
              )),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      MediaQuery.of(context).size.height * 0.30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality
                            .explosive, // don't specify a direction, blast randomly
                        shouldLoop:
                            false, // start again as soon as the animation is finished
                        colors: const [
                          Colors.lightGreen,
                          Colors.orange,
                          Colors.yellow,
                          Colors.white
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return fullScreenImage(
                                context, userData.imgUrl, sigmaX, sigmaY);
                          }));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(userData.imgUrl)),
                            Positioned.fill(
                                child: ClipOval(
                              child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                                  child: Container(
                                      color: Colors.black.withOpacity(0))),
                            )),
                          ],
                        ),
                      ),
                      Text('${userData.nickname},  ${userData.age.toString()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(MdiIcons.mapMarker,
                                size: 20.0, color: Colors.white),
                            Text('${userData.location}, Japan',
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                body: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: ListView(
                        children: <Widget>[
                          questionAnswer("Occupation", userData.occupation),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Interests',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 5),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    height: 40,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        if (userData.yodeling)
                                          interests("Games"),
                                        if (userData.shopping)
                                          interests("Shopping"),
                                        if (userData.makingBalloonAnimals)
                                          interests("Photography"),
                                        if (userData.cooking)
                                          interests("Karaoke"),
                                        if (userData.painting) interests("Art"),
                                        if (userData.movies)
                                          interests("Movies"),
                                        if (userData.sports)
                                          interests("Sports"),
                                        if (userData.writing)
                                          interests("Traveling"),
                                        if (userData.drinking)
                                          interests("Drinking"),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          questionAnswer("About me", userData.about),
                          //ANSWERS
                          questionAnswer(
                              "🛌 Do you make your bed in the morning?",
                              userData.bed ?? "Ask me!"),
                          questionAnswer(
                              "🤓 Do you read reviews, or just go with your gut?",
                              userData.reviews ?? "Ask me!"),
                          questionAnswer(
                              "🌮 If you could only eat one thing for the rest of your life, what would it be?",
                              userData.foreverEat),
                          questionAnswer(
                              "🌭 If you're eating a meal do you save the best thing for last or eat it first?",
                              userData.bestForLast ?? "Ask me!"),
                          questionAnswer("👽 Do you believe in aliens?",
                              userData.aliens ?? "Ask me!"),
                          questionAnswer(
                              "🚽 If you were a piece of furniture, what piece of furniture would you be?",
                              userData.furniture ?? "Ask me!"),
                          questionAnswer(
                              "🏠 Would you rather have a home in the beach or the mountains?",
                              userData.beachOrMountain ?? "Ask me!"),
                          questionAnswer(
                              "🍱 When you get take-out food do you eat out of the container or transfer the food to dishes?",
                              userData.takeOutFood ?? "Ask me!"),
                          questionAnswer(
                              "🏝 If you were deserted on an island what items would you bring with you?",
                              userData.desertedIsland ?? "Ask me!"),
                          questionAnswer(
                              "💒 If you were to choose between a glamorous wedding or a small ceremony at the city hall, which would you choose?",
                              userData.wedding ?? "Ask me!"),
                          questionAnswer("🏡 Your place or mine?",
                              userData.yourPlaceOrMine ?? "Ask me!"),
                          _buildStartChatBtn(userData),
                          //ANSWER MORE QUESTIONS BTN
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if ((snapshot.hasData && matches == 0) || matchID == null) {
            return Scaffold(
              body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Hexcolor("#FFF1BA"), Hexcolor("#F4AA33")],
                    stops: [0.2, 0.7],
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //GET NEW MATCH BUTTON
                      Box(),
                    ],
                  )),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget _buildStartChatBtn(UserData userData) {
    return Container(
      height: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
      child: PimpedButton(
          particle: DemoParticle(),
          pimpedWidgetBuilder: (context, controller) {
            return RaisedButton(
                child: Text('Share a 🍺 and chat!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () => {
                      controller.forward(from: 0.0),
                      startChat(),
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Message(
                              chatRoomID: chatID,
                              matchID: matchID,
                              nickname: userData.nickname,
                              imgUrl: userData.imgUrl,
                            )),
                      ),
                    });
          }),
    );
  }
}
