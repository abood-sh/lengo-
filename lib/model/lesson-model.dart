import 'dart:convert';

LessonModel lessonModelFromJson(String str) => LessonModel.fromJson(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toJson());

class LessonModel {
  LessonModel({
    this.uidLesson,
    this.level,
    this.audioStageOne,
    this.itemsStageOne,
    this.uidCorrectAnswerStageOne,
    this.listStageTwo,
    this.audioStageThree,
    this.correctAnswerStageThree,
    this.uid,
  });

  String uidLesson;
  int level;
  String audioStageOne;
  List<String> itemsStageOne;
  String uidCorrectAnswerStageOne;
  List<String> listStageTwo;
  String audioStageThree;
  String correctAnswerStageThree;
  String uid;

  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
    uidLesson: json["uid-lesson"],
    level: json["level"],
    audioStageOne: json["audio-stage-one"],
    itemsStageOne: json["items-stage-one"].toString().split(", "),
    uidCorrectAnswerStageOne: json["uid-correct-answer-stage-one"],
    listStageTwo: json["list-stage-two"].toString().split(", "),
    audioStageThree: json["audio-stage-three"],
    correctAnswerStageThree: json["correct-answer-stage-three"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "uid-lesson": uidLesson,
    "level": level,
    "audio-stage-one": audioStageOne,
    "items-stage-one": itemsStageOne.join(", "),
    "uid-correct-answer-stage-one": uidCorrectAnswerStageOne,
    "list-stage-two": listStageTwo.join(", "),
    "audio-stage-three": audioStageThree,
    "correct-answer-stage-three": correctAnswerStageThree,
    "uid": uid,
  };
}
