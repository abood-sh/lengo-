import 'dart:convert';
import 'package:lengo/enums/gender.dart';
import 'package:lengo/enums/level.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userName,
    this.email,
    this.uidLanguage,
    this.currentLevel,
    this.gender,
    this.score,
    this.uid,
  });

  String userName;
  String email;
  String uidLanguage;
  Level currentLevel;
  Gender gender;
  int score;
  String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["user-name"],
    email: json["email"],
    uidLanguage: json["uid-language"],
    currentLevel: (json["current-level"] == "") ? null : Level.values[json["current-level"]],
    gender: (json["gender"] == "") ? null : Gender.values[json["gender"]],
    score: json["score"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "user-name": userName,
    "email": email,
    "uid-language": uidLanguage,
    "current-level": currentLevel == null ? "" : currentLevel.index,
    "gender": gender == null ? "" : gender.index,
    "score": score,
    "uid": uid,
  };
}
