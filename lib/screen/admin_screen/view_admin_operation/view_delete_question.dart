import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/widgets/loader.dart';

class ViewDeleteQuestion extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String audioSrageOne;

 Future<void> getQuestion(String id, BuildContext context) async {
    try {
      print("try");
      showLoaderDialog(context);
     await db.collection("Lesson").doc(id).get().then((value) {
        audioSrageOne = value["audio-stage-one"];
        update();
      });
      print("End_try");
      print("End_Try $audioSrageOne");
     
     
      Navigator.pop(context);
    } catch (e) {
      print("catch");
    }
  }

  delete(String id, BuildContext context) async {
    Get.defaultDialog(
        content: Text("Are You Sure Do Want To Delete ?"),
        title: "",
        titlePadding: const EdgeInsets.all(0),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancle")),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).errorColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Lesson")
                    .doc(id)
                    .delete();
                Navigator.pop(context);
                final SnackBar snackBar = SnackBar(
                  content: Text("Deleted Successfully !"),
                  backgroundColor: Theme.of(context).primaryColor,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text("Delete"))
        ]);
  }
}
