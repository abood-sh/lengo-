import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/widgets/loader.dart';

class ViewUpdateQuestion extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String stageOneAudio;
  String level = "3";

  File imageOne;
  String imgaeOnePath;

  File imagetwo;
  String imgaeTwoPath;

  File imagethree;
  String imgaeThreePath;

  File imagefour;
  String imgaeFourPath;

  BuildContext context;

  final picker = ImagePicker();

  String audioStageThree;
  String correctAnswerStageThree;
  String listStageTwo;

  String titleOne = "";
  String titleTwo = "";
  String titleThree = "";
  String titleFour = "";

  String imagePathOne =
      "https://icon-library.com/images/10b2f6d95195994fca386842dae53bb2_71798.png";

  String imagePathTwo =
      "https://icon-library.com/images/10b2f6d95195994fca386842dae53bb2_71798.png";
  String imagePathThree =
      "https://icon-library.com/images/10b2f6d95195994fca386842dae53bb2_71798.png";
  String imagePathFour =
      "https://icon-library.com/images/10b2f6d95195994fca386842dae53bb2_71798.png";

  getFirstOption(String id) async {
    try {
      await db.collection("optionsLesson").doc(id).get().then((value) {
        titleOne = value["title"];
        imagePathOne = value["image"];
        update();
      });
    } catch (e) {
      print("catch getFirstOption");
    }
  }

    getSecondOption(String id) async {
    try {
      await db.collection("optionsLesson").doc(id).get().then((value) {
        titleTwo = value["title"];
        imagePathTwo = value["image"];
        update();
      });
    } catch (e) {
      print("catch getFirstOption");
    }
  }

  getThirdOption(String id) async {
    try {
      await db.collection("optionsLesson").doc(id).get().then((value) {
        titleThree = value["title"];
        imagePathThree = value["image"];
        update();
      });
    } catch (e) {
      print("catch getFirstOption");
    }
  }

    getFourthOption(String id) async {
    try {
      await db.collection("optionsLesson").doc(id).get().then((value) {
        titleFour = value["title"];
        imagePathFour = value["image"];
        update();
      });
    } catch (e) {
      print("catch getFirstOption");
    }
  }

  updateFirstOption(String id, String title, String imgPath) async {
    int dateTime = DateTime.now().millisecond + Random().nextInt(10000000);
    if (imageOne != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTime.toString());
      await storageRef.putFile(imageOne);

      imgaeOnePath = await storageRef.getDownloadURL();
      update();
    }

    await db.collection("optionsLesson").doc(id).update(
        {"title": title, "image": imageOne == null ? imgPath : imgaeOnePath});
  }

    updateSecondOption(String id, String title, String imgPath) async {
    int dateTime = DateTime.now().millisecond + Random().nextInt(10000000);
    if (imagetwo != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTime.toString());
      await storageRef.putFile(imagetwo);

      imgaeTwoPath = await storageRef.getDownloadURL();
      update();
    }

    await db.collection("optionsLesson").doc(id).update(
        {"title": title, "image": imagetwo == null ? imgPath : imgaeTwoPath});
  }

    updateThirdOption(String id, String title, String imgPath) async {
    int dateTime = DateTime.now().millisecond + Random().nextInt(10000000);
    if (imagethree != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTime.toString());
      await storageRef.putFile(imagethree);

      imgaeThreePath = await storageRef.getDownloadURL();
      update();
    }

    await db.collection("optionsLesson").doc(id).update(
        {"title": title, "image": imagethree == null ? imgPath : imgaeThreePath});
  }

    updateFourthOption(String id, String title, String imgPath) async {
    int dateTime = DateTime.now().millisecond + Random().nextInt(10000000);
    if (imagefour != null) {
      Reference storageRef = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTime.toString());
      await storageRef.putFile(imagefour);

      imgaeFourPath = await storageRef.getDownloadURL();
      update();
    }

    await db.collection("optionsLesson").doc(id).update(
        {"title": title, "image": imagefour == null ? imgPath : imgaeFourPath});
  }





  changeLevel(String newValue) {
    level = newValue;
    update();
  }

  getQuestionData(String id, BuildContext context) async {
    print("getQuestionData");
    try {
      print("print 0");
      await db.collection("Lesson").doc(id).get().then((value) {
        print("id : $id");
        stageOneAudio = value["audio-stage-one"];
        print("print 1");
        level = value["level"];
        print("print 2");
        audioStageThree = value["audio-stage-three"];
        print("print 3");
        correctAnswerStageThree = value["correct-answer-stage-three"];
        print("print 4");
        listStageTwo = value["list-stage-two"];
        print("print 5");
        update();
      });
      print("Try $stageOneAudio");
      print("Try $audioStageThree");
    } catch (e) {
      print("Catch $stageOneAudio");
    }
  }

  updateQuestion(
      BuildContext context,
      String id,
      String audioStageOne,
      String audioStageThree,
      String correctAnswerStageThree,
      String listStageTwo) async {
    showLoaderDialog(context, isShowLoader: true);

    try {
      await db.collection("Lesson").doc(id).update({
        "audio-stage-one": audioStageOne,
        "audio-stage-three": audioStageThree,
        "correct-answer-stage-three": correctAnswerStageThree,
        "level": int.parse(level),
        "list-stage-two": listStageTwo,
      });
      Navigator.pop(context);
      Navigator.pop(context);
      showLoaderDialog(context, isShowLoader: false);
    } catch (e) {
      showLoaderDialog(context, isShowLoader: false);
      print("Catch");
    }
  }

  Future getFirstImage(ImageSource source, int numberOfPhoto) async {
    print("Get Image");
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      if (numberOfPhoto == 1) {
        imageOne = File(pickedImage.path);
      } else if (numberOfPhoto == 2) {
        imagetwo = File(pickedImage.path);
      } else if (numberOfPhoto == 3) {
        imagethree = File(pickedImage.path);
      } else if (numberOfPhoto == 4) {
        imagefour = File(pickedImage.path);
      }
      update();
    } else {
      print("\n Null Photo  \n");
    }
  }

  void showAlertIamgeSourceOne(BuildContext context, int numberOfPhoto) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Choose Image Source"),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            getFirstImage(ImageSource.gallery, numberOfPhoto);
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Gallery",
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            color: Colors.black,
            height: 50,
            width: 130,
          ),
        ),
        InkWell(
            onTap: () {
              getFirstImage(ImageSource.camera, numberOfPhoto);
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "Camera",
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
              color: Colors.black,
              height: 50,
              width: 130,
            )),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
