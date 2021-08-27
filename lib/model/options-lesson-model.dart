import 'dart:convert';

OptionsLessonModel optionsLessonModelFromJson(String str) => OptionsLessonModel.fromJson(json.decode(str));

String optionsLessonModelToJson(OptionsLessonModel data) => json.encode(data.toJson());

class OptionsLessonModel {
  OptionsLessonModel({
    this.uidLesson,
    this.title,
    this.image,
    this.uid,
  });

  String uidLesson;
  String title;
  String image;
  String uid;

  factory OptionsLessonModel.fromJson(Map<String, dynamic> json) => OptionsLessonModel(
    uidLesson: json["uid-lesson"],
    title: json["title"],
    image: json["image"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "uid-lesson": uidLesson,
    "title": title,
    "image": image,
    "uid": uid,
  };
}
