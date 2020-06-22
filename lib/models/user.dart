class User {
  final String uid;
  bool isEmailVerified = false;

  User({
    this.uid,
    this.isEmailVerified,
  });
}

class UserData {
  final String uid;
  final String email;
  final String nickname;
  final String location;
  final int age;
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
  final bool isProfileCreated;
  final int matches;
  final String imgUrl;
  final String matchID;
  final String chatID;
  final String bed;
  final String reviews;
  final String foreverEat;
  final String bestForLast;
  final String aliens;
  final String furniture;
  final String beachOrMountain;
  final String takeOutFood;
  final String desertedIsland;
  final String wedding;
  final String yourPlaceOrMine;
  final String genderPreference;
  final double highAge;
  final double lowAge;
  final bool limitBlur;

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
      this.drinking,
      this.isProfileCreated,
      this.matches,
      this.imgUrl,
      this.matchID,
      this.chatID,
      this.bed,
      this.reviews,
      this.foreverEat,
      this.bestForLast,
      this.aliens,
      this.furniture,
      this.beachOrMountain,
      this.takeOutFood,
      this.desertedIsland,
      this.wedding,
      this.yourPlaceOrMine,
      this.genderPreference,
      this.highAge,
      this.lowAge,
      this.limitBlur});
}

class UserImg {
  final String imgUrl;

  UserImg({
    this.imgUrl,
  });
}

class Preferences {
  double lowValue;
  double highValue;
  String genderPreference;

  Preferences({this.lowValue, this.highValue, this.genderPreference});
}

class Answers {
  String bed;
  String reviews;
  String foreverEat;
  String bestForLast;
  String aliens;

  Answers(
      {this.bed, this.reviews, this.foreverEat, this.bestForLast, this.aliens});
}

//update this when you add more questions
class MoreAnswers {
  String furniture;
  String beachOrMountain;
  String takeOutFood;
  String desertedIsland;
  String wedding;
  String yourPlaceOrMine;

  MoreAnswers({
    this.furniture,
    this.beachOrMountain,
    this.takeOutFood,
    this.desertedIsland,
    this.wedding,
    this.yourPlaceOrMine,
  });
}
