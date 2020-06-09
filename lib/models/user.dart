//import 'dart:html';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String email;
  final String nickname;
  final String location;
  final String age;
  final String gender;
  final String occupation;
  final String about;
  final bool yodeling;
  final bool shopping;
  final bool makingBalloonAnimals;
  final bool cooking;
  final bool painting;
  final bool movies;
  final bool sports;
  final bool writing;
  final bool drinking;

  UserData(
      {this.uid,
      this.email,
      this.nickname,
      this.location,
      this.age,
      this.gender,
      this.occupation,
      this.about,
      this.yodeling,
      this.shopping,
      this.makingBalloonAnimals,
      this.cooking,
      this.painting,
      this.movies,
      this.sports,
      this.writing,
      this.drinking});
}

class UserImg {
  final String imgUrl;

  UserImg({
    this.imgUrl,
  });
}
