import 'dart:convert';

import 'package:lengo/enums/level.dart';

LevelCompleteModel levelCompleteModelFromJson(String str) => LevelCompleteModel.fromJson(json.decode(str));

String levelCompleteModelToJson(LevelCompleteModel data) => json.encode(data.toJson());

class LevelCompleteModel {
  LevelCompleteModel({
    this.uidCategory,
    this.uidUser,
    this.level,
    this.uid,
    this.languageLevel,
  });

  String uidCategory;
  String uidUser;
  int level;
  String uid;
  Level languageLevel;

  factory LevelCompleteModel.fromJson(Map<String, dynamic> json) => LevelCompleteModel(
    uidCategory: json["uid-category"],
    uidUser: json["uid-user"],
    level: json["level"],
    uid: json["uid"],
    languageLevel: Level.values[json["language-level"]]
  );

  Map<String, dynamic> toJson() => {
    "uid-category": uidCategory,
    "uid-user": uidUser,
    "level": level,
    "uid": uid,
    "language-level": languageLevel.index,
  };
}
