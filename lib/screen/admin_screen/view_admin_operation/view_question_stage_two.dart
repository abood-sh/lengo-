import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/add_question_stage_three_screen.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_add_question_stage_three.dart';
import 'package:lengo/widgets/loader.dart';

class ViewQusetionStageTwo extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

 void AddStageTwo(
    BuildContext context,
    String docId,
    String firstWordInEnglish,
    String firstWordInArabic,
    String secondWordInEnglish,
    String secondWordInArabic,
    String thirdWordInEnglish,
    String thirdWordInArabic,
    String forthWordInEnglish,
    String forthWordInArabic,
    String fifthhWordInEnglish,
    String fifthWordInArabic,
    String sexthWordInEnglish,
    String sexthWordInArabic,
  ) async {
    try {
      showLoaderDialog(context, isShowLoader: true);
      await db.collection("Lesson").doc(docId).update({
        "uid":docId,
        "list-stage-two":
            "$firstWordInEnglish : $firstWordInArabic, $secondWordInEnglish : $secondWordInArabic, $thirdWordInEnglish : $thirdWordInArabic, $forthWordInEnglish : $forthWordInArabic, $fifthhWordInEnglish : $fifthWordInArabic, $sexthWordInEnglish : $sexthWordInArabic"
      });

      showLoaderDialog(context, isShowLoader: false);
      Get.off(AddQuestionStageThreeScreen(docId: docId,));
      Get.lazyPut(() => ViewAddQuestionStageThree());
    } catch (e) {
      showLoaderDialog(context, isShowLoader: false);
    }
  }
}
