import 'dart:convert';

ActivityHistoryModel activityHistoryModelFromJson(String str) =>
    ActivityHistoryModel.fromJson(json.decode(str));

String activityHistoryModelToJson(ActivityHistoryModel data) =>
    json.encode(data.toJson());

class ActivityHistoryModel {
  ActivityHistoryModel({
    this.uidUser,
    this.date,
    this.uid,
    this.score,
  });

  String uidUser;
  DateTime date;
  String uid;
  int score;

  factory ActivityHistoryModel.fromJson(Map<String, dynamic> json) =>
      ActivityHistoryModel(
        uidUser: json["uid-user"],
        date: DateTime.parse(json["date"]),
        uid: json["uid"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "uid-user": uidUser,
        "date": date.toString(),
        "uid": uid,
        "score": score,
      };
}
