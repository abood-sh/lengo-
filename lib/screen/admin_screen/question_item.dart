import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/screen/admin_screen/update_question_screen.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_delete_question.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_update_question.dart';

// ignore: must_be_immutable
class QuestionItem extends GetWidget<ViewDeleteQuestion> {
  QuestionItem(
      {Key key,
      @required this.audioStageOne,
      @required this.audioCorrectAnswerUid,
      @required this.docId,
      @required this.audioStageThree,
      @required this.correctAnswerStageThree,
      @required this.level,
      @required this.listStageTwo,
      @required this.correctAnswerId,
      @required this.answerIds,
      })
      : super(key: key);

  final String audioStageOne;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final String audioCorrectAnswerUid;
  final String docId;
  final String audioStageThree;
  final String correctAnswerStageThree;
  final String level;
  final String listStageTwo;
  final String correctAnswerId;
  final String answerIds;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewDeleteQuestion>(
      init: ViewDeleteQuestion(),
      initState: (_) {},
      builder: (_) {
        return Card(
          child: ListTile(
            title: Row(
              children: [
                Text(audioStageOne),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      print(docId);
                      controller.delete(docId, context);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
                IconButton(
                    onPressed: () {
                      Get.lazyPut(() => ViewUpdateQuestion());
                      Get.to(() => 
                      UpdateQuestionScreen(
                        answerIds: answerIds,
                        correctAnswerId: correctAnswerId,
                        audioStageThree: audioStageThree,
                        level: level,
                        listStageTwo: listStageTwo,
                        audioStageOne: audioStageOne,
                        correctAnswerStageThree: correctAnswerStageThree,
                        docId: docId
                        ));
                     
                    },
                    icon: Icon(Icons.edit)),
              ],
            ),
            subtitle: StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("optionsLesson")
                  .where("uid", isEqualTo: audioCorrectAnswerUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return Text(snapshot.data.docs.elementAt(0).get("title"));
              },
            ),
          ),
        );
      },
    );
  }
}
