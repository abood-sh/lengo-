import 'dart:convert';

LanguageModel languageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  LanguageModel({
    this.name,
    this.image,
    this.uid,
    this.isActive,
  });

  String name;
  String image;
  String uid;
  bool isActive;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    name: json["name"],
    image: json["image"],
    uid: json["uid"],
    isActive: json["is-active"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "uid": uid,
    "is-active": isActive,
  };
}
