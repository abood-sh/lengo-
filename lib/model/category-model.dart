import 'dart:convert';
import 'package:lengo/enums/level.dart';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.image,
    this.uidLanguage,
    this.name,
    this.levelsCount,
    this.uid,
    this.currentlyLevel,
    this.level,
  });

  String image;
  String uidLanguage;
  String name;
  int levelsCount;
  String uid;
  int currentlyLevel;
  Level level;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    image: json["image"],
    uidLanguage: json["uid-language"],
    name: json["name"],
    levelsCount: json["levels-count"],
    uid: json["uid"],
    currentlyLevel: json["currently-level"],
    level: Level.values[json["level"]],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "uid-language": uidLanguage,
    "name": name,
    "levels-count": levelsCount,
    "uid": uid,
    "currently-level": currentlyLevel,
    "level": level.index,
  };
}
