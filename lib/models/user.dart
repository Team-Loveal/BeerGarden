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
  final String interests;

  UserData(
      {this.uid,
      this.email,
      this.nickname,
      this.location,
      this.age,
      this.gender,
      this.occupation,
      this.about,
      this.interests});
}
