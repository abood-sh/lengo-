import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lengo/enums/auth_page_type.dart';
import 'package:lengo/enums/gender.dart';
import 'package:lengo/enums/level.dart';
import 'package:lengo/model/activity-history-model.dart';
import 'package:lengo/model/category-model.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/model/lesson-model.dart';
import 'package:lengo/model/level-complete-model.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/screen/admin_screen/admin_screen.dart';
import 'package:lengo/utils/user_profile.dart';
import 'package:lengo/widgets/loader.dart';
import 'package:lengo/utils/extensions.dart';

class FirebaseManger {

  static final FirebaseManger shard = FirebaseManger();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection('User');
  final languageRef = FirebaseFirestore.instance.collection('Language');
  final categoryRef = FirebaseFirestore.instance.collection('Category');
  final lessonRef = FirebaseFirestore.instance.collection('Lesson');
  final optionsLessonRef = FirebaseFirestore.instance.collection('optionsLesson');
  final levelCompleteRef = FirebaseFirestore.instance.collection('levelComplete');
  final activityHistoryRef = FirebaseFirestore.instance.collection('activityHistory');
  final storageRef = FirebaseStorage.instance.ref();

  login({ @required GlobalKey<ScaffoldState> scaffoldKey, @required String email, @required String password }) async {

    showLoaderDialog(scaffoldKey.currentContext);

    try {
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(email=="admin@email.com"){
          Navigator.of(scaffoldKey.currentContext).
          pushReplacement(MaterialPageRoute(builder: (_)=> AdminScreen()));
      }


      await getUserByUid(uid: auth.currentUser.uid).then((user) => {
        showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false),
        if (user.gender != null) {
          UserProfile.shared.setUser(user: user),
          Navigator.of(scaffoldKey.currentContext).pushNamedAndRemoveUntil('/TabBar', (Route<dynamic> route) => false),
        } else {
          Navigator.of(scaffoldKey.currentContext).pushNamedAndRemoveUntil('/SignupCompleteData', (Route<dynamic> route) => false),
        }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        scaffoldKey.showTosta(message: "user not found", isError: true);
      } else if (e.code == 'wrong-password') {
        scaffoldKey.showTosta(message: "wrong password", isError: true);
      } else if (e.code == 'too-many-requests') {
        scaffoldKey.showTosta(message: "The account is temporarily locked", isError: true);
      }
    }

    showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
    return;
  }

  Future<String> _createAccountInFirebase({GlobalKey<ScaffoldState> scaffoldKey, String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        scaffoldKey.showTosta(message: "the email is already used", isError: true);
      }
      return null;
    } catch (e) {
      scaffoldKey.showTosta(message: "something went wrong", isError: true);
      print(e);
      return null;
    }
  }

  Future<UserModel> getUserByUid({ @required String uid }) async {

    UserModel userTemp;

    var user = await userRef.doc(uid).snapshots().first;

    userTemp = UserModel.fromJson(user.data());

    return userTemp;
  }

  createAccountUser (
      {
        @required GlobalKey<ScaffoldState> scaffoldKey,
        @required String userName,
        @required String email,
        @required String password,
      }) async {

    showLoaderDialog(scaffoldKey.currentContext);

    if (!email.isValidEmail()) {
      scaffoldKey.showTosta(message: "please enter a valid email", isError: true);
      showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
      return;
    }

    var userId = await _createAccountInFirebase(scaffoldKey: scaffoldKey, email: email, password: password);

    if (userId != null) {
      userRef.doc(userId).set({
        "user-name": userName,
        "email": email,
        "uid-language": "",
        "current-level": "",
        "gender": "",
        "score": 0,
        "uid": userId,
      })
          .then((value) {
        showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
        Navigator.pushReplacementNamed(scaffoldKey.currentContext, "/Auth", arguments: AuthPageType.SIGN_IN);
      })
          .catchError((err) {
        showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
        scaffoldKey.showTosta(message: "Something went wrong", isError: true);
      });
    } else {
      showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
    }

  }

  Future<bool> increaseLevel () async {

    UserModel user = await getUserByUid(uid: auth.currentUser.uid);

    if (user.currentLevel.index >= 2) {
      return false;
    }

    userRef.doc(auth.currentUser.uid).update({
      "current-level": user.currentLevel.index + 1,
    })
        .then((value) async {
          UserModel user = await UserProfile.shared.getUser();
          user.currentLevel = Level.values[user.currentLevel.index + 1];
          UserProfile.shared.setUser(user: user);
      return true;
    })
        .catchError((err) {
      return false;
    });

    return true;
  }

  Stream<List<UserModel>> getAllUsers() {

    return userRef.orderBy("score", descending: true).snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
    });

  }

  completeUserData (
      {
        @required GlobalKey<ScaffoldState> scaffoldKey,
        @required String uidLanguage,
        @required Level currentLevel,
        @required Gender gender,
      }) async {

    showLoaderDialog(scaffoldKey.currentContext);

    var userId = auth.currentUser.uid;

    if (userId != null) {
      userRef.doc(userId).update({
        "uid-language": uidLanguage,
        "current-level": currentLevel.index,
        "gender": gender.index,
      })
          .then((value) async {
        showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
        await getUserByUid(uid: auth.currentUser.uid).then((user) => {
          UserProfile.shared.setUser(user: user),
        });
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentContext, "/TabBar", (route) => false);
      })
          .catchError((err) {
        showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
        scaffoldKey.showTosta(message: "Something went wrong", isError: true);
      });
    } else {
      showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
    }

  }

  Future<bool> forgotPassword({ @required GlobalKey<ScaffoldState> scaffoldKey, @required String email }) async {

    if (!email.isValidEmail()) {
      scaffoldKey.showTosta(message: "please enter a valid email", isError: true);
      showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
      return false;
    }

    showLoaderDialog(scaffoldKey.currentContext);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
      return true;
    } on FirebaseAuthException catch (e) {
      showLoaderDialog(scaffoldKey.currentContext, isShowLoader: false);
      if (e.code == 'user-not-found') {
        scaffoldKey.showTosta(message: "Email not found", isError: true);
        return false;
      }
    }

  }

  logout(context) async {
    try {
      showLoaderDialog(context);

      await FirebaseAuth.instance.signOut();
      await UserProfile.shared.setUser(user: null);
      showLoaderDialog(context, isShowLoader: false);
      Navigator.pushNamedAndRemoveUntil(context, "/GetStart", (route) => false);
    } catch (_) {
      showLoaderDialog(context, isShowLoader: false);
    }
  }

  addLanguage(
      {
        @required String name,
        @required String image,
        bool isActive = true,
      }
      ) {

    String uid = languageRef.doc().id;

    languageRef.doc(uid).set({
      "name": name,
      "image": image,
      "uid": uid,
      "is-active": isActive,
    })
        .then((value) {

    })
        .catchError((err) {

    });

  }

  Stream<List<LanguageModel>> getAllLanguages() {

    return languageRef.snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return LanguageModel.fromJson(doc.data());
      }).toList();
    });

  }

  Stream<LanguageModel> getLanguageByUid({ @required String uid }) {
    return languageRef.doc(uid).snapshots().map((DocumentSnapshot snapshot) {
      return LanguageModel.fromJson(snapshot.data());
    });
  }

  addActivityHistory() async {

    String uid = activityHistoryRef.doc().id;
    int score = 10;

    List<ActivityHistoryModel> activityHistory = await this.getActivityHistory().first;

    var date1 = DateTime.now();

    for (var item in activityHistory) {
      var date2 = item.date;
      var difference = date1.difference(date2).inDays;
      if (difference < 8 && (date1.weekday == date2.weekday)) {
        uid = item.uid;
        score = item.score + 10;
        break;
      }
    }

    activityHistoryRef.doc(uid).set({
      "uid-user": auth.currentUser.uid,
      "date": DateTime.now().toString(),
      "score": score,
      "uid": uid,
    })
        .then((value) {

    })
        .catchError((err) {

    });

  }

  Stream<List<ActivityHistoryModel>> getActivityHistory() {

    return activityHistoryRef.where("uid-user", isEqualTo: auth.currentUser.uid).snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return ActivityHistoryModel.fromJson(doc.data());
      }).toList();
    });

  }

  addCategory(
      {
        @required String image,
        @required String uidLanguage,
        @required String name,
        @required int levelsCount,
        @required Level level,
      }
      ) {

    String uid = categoryRef.doc().id;

    categoryRef.doc(uid).set({
      "image": image,
      "uid-language": uidLanguage,
      "name": name,
      "levels-count": levelsCount,
      "level": 2,
      "uid": uid,
    })
        .then((value) {

    })
        .catchError((err) {

    });

  }

  Stream<List<CategoryModel>> getCategoryByLanguage({ @required String uidLanguage }) {

    return categoryRef.where("uid-language", isEqualTo: uidLanguage).snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data());
      }).toList();
    });

  }

  addLesson(
      {
        @required String uidLesson,
        @required int level,
        @required String audioStageOne,
        @required List<String> itemsStageOne, // ref optionsLessonRef
        @required String uidCorrectAnswerStageOne,
        @required List<String> listStageTwo,
        @required String audioStageThree,
        @required String correctAnswerStageThree,
      }
      ) {

    String uid = lessonRef.doc().id;

    lessonRef.doc(uid).set({
      "uid-lesson": uidLesson,
      "level": level,
      "audio-stage-one": audioStageOne,
      "items-stage-one": itemsStageOne.join(", "),
      "uid-correct-answer-stage-one": uidCorrectAnswerStageOne,
      "list-stage-two": listStageTwo.join(", "),
      "audio-stage-three": audioStageThree,
      "correct-answer-stage-three": correctAnswerStageThree,
      "uid": uid,
    })
        .then((value) {

    })
        .catchError((err) {

    });

  }

  Stream<List<LessonModel>> getLessonByCategoryUid({ @required String uidCategory }) {

    return lessonRef.where("uid-lesson", isEqualTo: uidCategory).snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return LessonModel.fromJson(doc.data());
      }).toList();
    });

  }

  addOptionLesson(
      {
        @required String uidLesson,
        @required String title,
        @required String image,
      }
      ) {

    String uid = optionsLessonRef.doc().id;

    optionsLessonRef.doc(uid).set({
      "uid-lesson": uidLesson,
      "title": title,
      "image": image,
      "uid": uid,
    })
        .then((value) {

    })
        .catchError((err) {

    });

  }

  Stream<OptionsLessonModel> getOtionLessonByUid({ @required String uid }) {

    return optionsLessonRef.doc(uid).snapshots().map((DocumentSnapshot snapshot) {
      return OptionsLessonModel.fromJson(snapshot.data());
    });

  }

  increaseScore() async {

    UserModel user = await getUserByUid(uid: auth.currentUser.uid);

    this.addActivityHistory();

    userRef.doc(auth.currentUser.uid).update({
      "score": user.score + 10,
    });

  }

  addLevelComplete(
      {
        @required String uidCategory,
      }
      ) async {

    int level = 1;

    String uid = levelCompleteRef.doc().id;

    UserModel user = await UserProfile.shared.getUser();

    List<LevelCompleteModel> levelComplete = await getCompleteLevel().first;

    for (var item in levelComplete) {
      if (item.uidCategory == uidCategory) {
        level = item.level + 1;
        uid = item.uid;
      }
    }

    levelCompleteRef.doc(uid).set({
      "uid-category": uidCategory,
      "uid-user": auth.currentUser.uid,
      "level": level,
      "language-level": user.currentLevel.index,
      "uid": uid,
    })
        .then((value) {

    })
        .catchError((err) {

    });

  }

  Stream<List<LevelCompleteModel>> getCompleteLevel() {

    return levelCompleteRef.where("uid-user", isEqualTo: auth.currentUser.uid).snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return LevelCompleteModel.fromJson(doc.data());
      }).toList();
    });

  }

  Future<double> getUserCompletionPercentage({ @required uidLanguage }) async {

    double totalCount = 0;
    double totalComplateLevel = 0;

    UserModel user = await this.getUserByUid(uid: auth.currentUser.uid);

    List<CategoryModel> categores = await getCategoryByLanguage(uidLanguage: uidLanguage).first;

    for (var item in categores) {
      if (item.level == user.currentLevel) {
        totalCount += item.levelsCount;
      }
    }

    List<LevelCompleteModel> levelComplete = await getCompleteLevel().first;

    for (var item in levelComplete) {
      if (item.languageLevel == user.currentLevel) {
        totalComplateLevel += item.level;
      }
    }

    return totalCount == 0 ? 0 : (totalComplateLevel / totalCount) * 100;
  }

}