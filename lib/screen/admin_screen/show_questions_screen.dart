import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lengo/screen/admin_screen/question_item.dart';

// ignore: must_be_immutable
class ShowQuestionsScreen extends StatelessWidget {
  ShowQuestionsScreen({Key key, @required this.id}) : super(key: key);

  FirebaseFirestore db = FirebaseFirestore.instance;
  final String id;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection("Lesson")
            .where("uid-lesson", isEqualTo: id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data.docs.map((doc) {
                return QuestionItem(
                  answerIds: doc["items-stage-one"],
                  correctAnswerId: doc["uid-correct-answer-stage-one"],
                  listStageTwo: doc["list-stage-two"],
                  level: doc["level"].toString(),
                  audioStageThree: doc["audio-stage-three"],
                  correctAnswerStageThree: doc["correct-answer-stage-three"],
                  docId: doc.id,
                  audioCorrectAnswerUid: doc["uid-correct-answer-stage-one"],
                  audioStageOne: doc["audio-stage-one"],
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
