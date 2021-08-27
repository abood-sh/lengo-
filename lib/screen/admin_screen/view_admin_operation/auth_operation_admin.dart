import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/screen/admin_screen/add_question_stage_two_screen.dart';
import 'package:lengo/widgets/loader.dart';

import 'view_question_stage_two.dart';

class AuthOperationAdmin extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool firstCheckBox = true;
  bool secondCheckBox = false;
  bool thirdheCkBox = false;
  bool fourthCheckBox = false;

  changeFirst(bool newVal, int number) {
    if (number == 1) {
      firstCheckBox = newVal;
      secondCheckBox = false;
      thirdheCkBox = false;
      fourthCheckBox = false;
    } else if (number == 2) {
      secondCheckBox = newVal;
      firstCheckBox = false;
      thirdheCkBox = false;
      fourthCheckBox = false;
    } else if (number == 3) {
      firstCheckBox = false;
      fourthCheckBox = false; 
      secondCheckBox = false;
      thirdheCkBox = newVal;
    } else if (number == 4) {
      firstCheckBox = false;
      thirdheCkBox = false; 
      secondCheckBox = false;
      fourthCheckBox = newVal;
    }

    update();
  }

  File imageOne;
  File imagetwo;
  File imagethree;
  File imagefour;

  String imageOnePath;
  String imagetwoPath;
  String imagethreePath;
  String imagefourPath;

  File image;
  final picker = ImagePicker();
  String dropdownValue = 'Simple';
  String dropdownValueLanguge = 'German';
  List<String> myList = [];
  int level = 0;
  String uid_language = "";
  String dropDown = "1";

  void changeDropDown(String newValue) {
    dropDown = newValue;
    update();
  }

  void onChangeDropDownList(String newValue) {
    dropdownValue = newValue;
    if (newValue == "Simple") {
      level = 0;
    } else if (newValue == "Meduim") {
      level = 1;
    } else {
      level = 2;
    }
    update();
  }

  void onChangeDropDownLanguge(String newValue) async {
    await db
        .collection("Language")
        .where("name", isEqualTo: newValue)
        .get()
        .then((value) => {uid_language = value.docs[0]["uid"]});
    dropdownValueLanguge = newValue;
    update();
  }

  void showAlert(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Choose Image Source"),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            getImage(ImageSource.gallery);
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
              getImage(ImageSource.camera);
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

  Future getImage(ImageSource source) async {
    print("Get Image");
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
    } else {
      print("\n Null Photo  \n");
    }
  }

  Future<void> addCategorey(BuildContext context, String name, int countLevel,
      int level, String uidLanguage, File image) async {
    try {
      showLoaderDialog(context);
      int dateTime = DateTime.now().millisecond + Random().nextInt(10000000);
      Reference storageRef =
          FirebaseStorage.instance.ref("category").child(dateTime.toString());
      await storageRef.putFile(image);
      print("Befor Url");
      print(await storageRef.getDownloadURL());
      DocumentReference ref = await db.collection("Category").add({
        "name": name,
        "level": level,
        "levels-count": countLevel,
        "uid-language": uidLanguage,
        "image": await storageRef.getDownloadURL()
      });

      await ref.update({"uid": ref.id});

      showLoaderDialog(context, isShowLoader: false);
      Navigator.pop(context);
    } catch (e) {
      showLoaderDialog(context, isShowLoader: false);
      Get.snackbar(
        "Error",
        "SomeThing Get Wrong",
        backgroundColor: Colors.red,
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> getLanguges() async {
    await db.collection("Language").get().then((value) => {
          value.docs.forEach((element) {
            myList.add(element["name"]);
            update();
          })
        });
  }

  Future getFirstImage(ImageSource source) async {
    print("Get Image");
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      imageOne = File(pickedImage.path);
      update();
    } else {
      print("\n Null Photo  \n");
    }
  }

  Future getSecondImage(ImageSource source) async {
    print("Get Image");
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      imagetwo = File(pickedImage.path);
      update();
    } else {
      print("\n Null Photo  \n");
    }
  }

  Future getThirdImage(ImageSource source) async {
    print("Get Image");
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      imagethree = File(pickedImage.path);
      update();
    } else {
      print("\n Null Photo  \n");
    }
  }

  Future getForthImage(ImageSource source) async {
    print("Get Image");
    final pickedImage = await picker.getImage(source: source);
    if (pickedImage != null) {
      imagefour = File(pickedImage.path);
      update();
    } else {
      print("\n Null Photo  \n");
    }
  }

  void showAlertIamgeSourceOne(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Choose Image Source"),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            getFirstImage(ImageSource.gallery);
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
              getFirstImage(ImageSource.camera);
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

  void showAlertIamgeSourceTwo(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Choose Image Source"),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            getSecondImage(ImageSource.gallery);
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
              getSecondImage(ImageSource.camera);
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

  void showAlertIamgeSourceThree(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Choose Image Source"),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            getThirdImage(ImageSource.gallery);
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
              getThirdImage(ImageSource.camera);
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

  void showAlertIamgeSourceFour(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Choose Image Source"),
      elevation: 10,
      actions: [
        InkWell(
          onTap: () {
            getForthImage(ImageSource.gallery);
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
              getForthImage(ImageSource.camera);
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

  Future<void> addQuestionStepOne(
      BuildContext context,
      String audioStageOne,
      int level,
      OptionsLessonModel answerOne,
      OptionsLessonModel answerTwo,
      OptionsLessonModel answerThree,
      OptionsLessonModel answerFour,
      String newDocId) async {
    try {
      showLoaderDialog(context, isShowLoader: true);

      DocumentReference docRef = await db.collection("optionsLesson").add(
            answerOne.toJson(),
          );

      answerOne.uid = docRef.id;

      int dateTime = DateTime.now().millisecond + Random().nextInt(10000000);

      Reference storageRef = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTime.toString());
      await storageRef.putFile(imageOne);

      imageOnePath = await storageRef.getDownloadURL();
      update();

      answerOne.image = imageOnePath;
      db.collection("optionsLesson").doc(docRef.id).update(answerOne.toJson());

//----------------------------------------------------------------------------------------
      DocumentReference docRefTwo = await db.collection("optionsLesson").add(
            answerTwo.toJson(),
          );

      answerTwo.uid = docRefTwo.id;

      int dateTimeTwo = DateTime.now().microsecond + Random().nextInt(10000000);
      Reference storageRefTwo = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTimeTwo.toString());
      await storageRefTwo.putFile(imagetwo);

      imagetwoPath = await storageRefTwo.getDownloadURL();
      update();

      answerTwo.image = imagetwoPath;
      db
          .collection("optionsLesson")
          .doc(docRefTwo.id)
          .update(answerTwo.toJson());

//--------------------------------------------------------------------------------

      DocumentReference docRefThree = await db.collection("optionsLesson").add(
            answerThree.toJson(),
          );

      answerThree.uid = docRefThree.id;

      int dateTimeThree =
          DateTime.now().millisecondsSinceEpoch + Random().nextInt(10000000);
      Reference storageRefThree = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTimeThree.toString());
      await storageRefThree.putFile(imagethree);

      imagethreePath = await storageRefThree.getDownloadURL();
      update();

      answerThree.image = imagethreePath;
      db
          .collection("optionsLesson")
          .doc(docRefThree.id)
          .update(answerThree.toJson());

      //----------------------------------------------------------------------------------------
      DocumentReference docRefFour = await db.collection("optionsLesson").add(
            answerFour.toJson(),
          );

      answerFour.uid = docRefFour.id;

      int dateTimeFour =
          DateTime.now().millisecond + Random().nextInt(10000000);
      Reference storageRefFour = FirebaseStorage.instance
          .ref("LessonOption")
          .child(dateTimeFour.toString());
      await storageRefFour.putFile(imagefour);

      imagefourPath = await storageRefFour.getDownloadURL();
      update();

      answerFour.image = imagefourPath;
      db
          .collection("optionsLesson")
          .doc(docRefFour.id)
          .update(answerFour.toJson());


       String correctId = docRef.id;
      if(firstCheckBox == true){
          correctId = docRef.id;
          update();
      }else if(secondCheckBox == true){
          correctId = docRefTwo.id;
           update();
      }else if(thirdheCkBox == true){
          correctId = docRefThree.id;
           update();
      }else if(fourthCheckBox == true){
          correctId = docRefFour.id;
           update();
      }

      print("Correct Id $correctId");
      DocumentReference lesson = await db.collection("Lesson").add({
        "uid-lesson": newDocId,
        "audio-stage-one": audioStageOne,
        "uid-correct-answer-stage-one": correctId,
        "items-stage-one":
            "${docRef.id}, ${docRefTwo.id}, ${docRefThree.id}, ${docRefFour.id}",
        "level": level
      });

      answerOne.uidLesson = lesson.id;
      await db
          .collection("optionsLesson")
          .doc(docRef.id)
          .update(answerOne.toJson());

      answerTwo.uidLesson = lesson.id;
      await db
          .collection("optionsLesson")
          .doc(docRefTwo.id)
          .update(answerTwo.toJson());

      answerThree.uidLesson = lesson.id;
      await db
          .collection("optionsLesson")
          .doc(docRefThree.id)
          .update(answerThree.toJson());

      answerFour.uidLesson = lesson.id;
      await db
          .collection("optionsLesson")
          .doc(docRefFour.id)
          .update(answerFour.toJson());

      imageOne = null;
      imagetwo = null;
      imagethree = null;
      imagefour = null;
      showLoaderDialog(context, isShowLoader: false);
      Get.to(() => AddQuestionStageTwoScreen(docId: lesson.id));
      Get.lazyPut(() => ViewQusetionStageTwo());
    } catch (e) {
      showLoaderDialog(context, isShowLoader: false);
    }
  }
}
