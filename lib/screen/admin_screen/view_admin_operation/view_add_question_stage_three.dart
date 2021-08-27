import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/admin_screen.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_delete_question.dart';
import 'package:lengo/widgets/loader.dart';

class ViewAddQuestionStageThree extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void addStageThree(BuildContext context, String docId, String audioStageThree,
      String correctAnswerStageThree) async {
    try {
      showLoaderDialog(context);
      await db.collection("Lesson").doc(docId).update({
        "audio-stage-three": audioStageThree,
        "correct-answer-stage-three": correctAnswerStageThree
      });
      showLoaderDialog(context,isShowLoader: false);
      Get.offAll(AdminScreen());
       Get.lazyPut(() => ViewDeleteQuestion);
    } catch (e) {
      print("Error");
       showLoaderDialog(context,isShowLoader: false);
    }
  }
}
