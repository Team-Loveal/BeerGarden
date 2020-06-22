import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lovealapp/models/user.dart';

class DatabaseService {
  final String uid;
  bool isEmailVerified = false;
  DatabaseService({this.uid, this.isEmailVerified});

  final CollectionReference usersCollection =
      Firestore.instance.collection("users");

  final CollectionReference messagesCollection =
      Firestore.instance.collection("messages");

  //set user data when signing up
  Future setUserData(String email) async {
    return await usersCollection.document(uid).setData({
      'email': email,
      'nickname': "",
      'location': "",
      'age': "",
      'gender': "",
      'occupation': "",
      'about': "",
      'isProfileCreated': false,
      'limitBlur': false,
      'outOfMatches': false,
    });
  }

  //update user data when creating profile
  Future updateUserData(
      String nickname,
      String location,
      int age,
      String gender,
      String occupation,
      String about,
      bool yodeling,
      bool shopping,
      bool makingBalloonAnimals,
      bool cooking,
      bool painting,
      bool movies,
      bool sports,
      bool writing,
      bool drinking) async {
    return await usersCollection.document(uid).updateData({
      'nickname': nickname,
      'location': location,
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'about': about,
      'yodeling': yodeling,
      'shopping': shopping,
      'makingBalloonAnimals': makingBalloonAnimals,
      'cooking': cooking,
      'painting': painting,
      'movies': movies,
      'sports': sports,
      'writing': writing,
      'drinking': drinking,
      'matches': 0,
    });
  }

  Future editUserData(
      String nickname,
      String location,
      int age,
      String gender,
      String occupation,
      String about,
      bool yodeling,
      bool shopping,
      bool makingBalloonAnimals,
      bool cooking,
      bool painting,
      bool movies,
      bool sports,
      bool writing,
      bool drinking) async {
    return await usersCollection.document(uid).updateData({
      'nickname': nickname,
      'location': location,
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'about': about,
      'yodeling': yodeling,
      'shopping': shopping,
      'makingBalloonAnimals': makingBalloonAnimals,
      'cooking': cooking,
      'painting': painting,
      'movies': movies,
      'sports': sports,
      'writing': writing,
      'drinking': drinking,
    });
  }

  Future profileComplete(bool isProfileCompleted) async {
    return await usersCollection.document(uid).updateData({
      'isProfileCreated': isProfileCompleted,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data['email'],
      nickname: snapshot.data['nickname'],
      location: snapshot.data['location'],
      age: snapshot.data['age'],
      gender: snapshot.data['gender'],
      occupation: snapshot.data['occupation'],
      about: snapshot.data['about'],
      yodeling: snapshot.data['yodeling'],
      shopping: snapshot.data['shopping'],
      makingBalloonAnimals: snapshot.data['makingBalloonAnimals'],
      cooking: snapshot.data['cooking'],
      painting: snapshot.data['painting'],
      movies: snapshot.data['movies'],
      sports: snapshot.data['sports'],
      writing: snapshot.data['writing'],
      drinking: snapshot.data['drinking'],
      matches: snapshot.data['matches'],
      imgUrl: snapshot.data['imgUrl'],
      genderPreference: snapshot.data['genderPreference'],
      highAge: snapshot.data['highAge'],
      lowAge: snapshot.data['lowAge'],
      bed: snapshot.data['bed'],
      reviews: snapshot.data['reviews'],
      foreverEat: snapshot.data['foreverEat'],
      bestForLast: snapshot.data['bestForLast'],
      aliens: snapshot.data['aliens'],
      furniture: snapshot.data['furniture'],
      beachOrMountain: snapshot.data['beachOrMountain'],
      takeOutFood: snapshot.data['takeOutFood'],
      desertedIsland: snapshot.data['desertedIsland'],
      wedding: snapshot.data['wedding'],
      yourPlaceOrMine: snapshot.data['yourPlaceOrMine'],
      isProfileCreated: snapshot.data['isProfileCreated'],
      limitBlur: snapshot.data['limitBlur'],
      outOfMatches: snapshot.data['outOfMatches'],
    );
  }

  //get user doc stream
  //used when populating user data in preview profile and edit profile
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //update user img when uploaded
  Future updateUserImg(
    String imgUrl,
  ) async {
    return await usersCollection.document(uid).updateData({
      'imgUrl': imgUrl,
    });
  }

  //userData from snapshot
  UserImg _userImgFromSnapshot(DocumentSnapshot snapshot) {
    return UserImg(
      imgUrl: snapshot.data['imgUrl'],
    );
  }

  Stream<UserImg> get userImg {
    return usersCollection.document(uid).snapshots().map(_userImgFromSnapshot);
  }

  //set and update preferences to filter out matches
  Future updatePreference(
    double lowValue,
    double highValue,
    String genderPreference,
  ) async {
    return await usersCollection.document(uid).updateData({
      'lowAge': lowValue,
      'highAge': highValue,
      'genderPreference': genderPreference,
    });
  }

  //write answers to questions
  Future updateAnswers(
    String bed,
    String reviews,
    String foreverEat,
    String bestForLast,
    String aliens,
  ) async {
    return await usersCollection.document(uid).updateData({
      'bed': bed,
      'reviews': reviews,
      'foreverEat': foreverEat,
      'bestForLast': bestForLast,
      'aliens': aliens,
    });
  }

  //write answers to more questions
  //update this when you add more questions
  Future updateMoreAnswers(
    String furniture,
    String beachOrMountain,
    String takeOutFood,
    String desertedIsland,
    String wedding,
    String yourPlaceOrMine,
  ) async {
    return await usersCollection.document(uid).updateData({
      'furniture': furniture,
      'beachOrMountain': beachOrMountain,
      'takeOutFood': takeOutFood,
      'desertedIsland': desertedIsland,
      'wedding': wedding,
      'yourPlaceOrMine': yourPlaceOrMine,
    });
  }

  Future createMatches(genderPreference, lowAge, highAge) async {
    print(genderPreference);
    print(lowAge);
    print(highAge);
    if (genderPreference == "Everyone") {
      usersCollection
          .where('age', isGreaterThanOrEqualTo: lowAge)
          .where('age', isLessThanOrEqualTo: highAge)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((document) {
          if (document.documentID != uid) {
            //concat and make into a string and push into chatIds array
            String toID = document.documentID;
            String chatId1 = '$uid - ${document.documentID}';
            String chatId2 = '${document.documentID} - $uid';
            //check messages documents, if it doesn't exist write to the db
            messagesCollection.getDocuments().then((querySnapshot) {
              querySnapshot.documents.forEach((document) {
                if (chatId1 != document.documentID &&
                    chatId2 != document.documentID) {
                  messagesCollection.document(chatId1).setData({
                    'fromID': uid,
                    'toID': toID,
                    'matched': false,
                    'active': false,
                    'matchedUsers': [uid, toID],
                    'blur': 50,
                  });
                }
              });
            });
          }
        });
      });
    } else {
      usersCollection
          .where('age', isGreaterThanOrEqualTo: lowAge)
          .where('age', isLessThanOrEqualTo: highAge)
          .where('gender', isEqualTo: genderPreference)
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((document) {
          if (document.documentID != uid) {
            //concat and make into a string and push into chatIds array
            String toID = document.documentID;
            String chatId1 = '$uid - ${document.documentID}';
            String chatId2 = '${document.documentID} - $uid';
            //check messages documents, if it doesn't exist write to the db
            messagesCollection
                .where('matched', isEqualTo: false)
                .getDocuments()
                .then((querySnapshot) {
              querySnapshot.documents.forEach((document) {
                if (chatId1 != document.documentID &&
                    chatId2 != document.documentID) {
                  messagesCollection.document(chatId1).setData({
                    'fromID': uid,
                    'toID': toID,
                    'matched': false,
                    'active': false,
                    'matchedUsers': [uid, toID],
                    'blur': 50,
                  });
                }
              });
            });
          }
        });
      });
    }
  }

  Future deleteMatches() async {
    await messagesCollection
        .where('matchedUsers', arrayContains: uid)
        .where('matched', isEqualTo: false)
        .where('active', isEqualTo: false)
        .getDocuments()
        .then((querySnapshot) =>
            querySnapshot.documents.forEach((document) async {
              // delete all documents in subcollection first
              await messagesCollection
                  .document(document.documentID)
                  .collection('chatroom')
                  .getDocuments()
                  .then((querySnapshot) => querySnapshot.documents
                      .forEach((document) => {document.reference.delete()}));
              // then remove all documents in collection
              document.reference.delete();
            }))
        .catchError((error) => {print('Could not delete matches: $error')});
  }
}
