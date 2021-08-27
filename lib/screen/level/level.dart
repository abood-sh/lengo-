import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lengo/enums/level.dart';
import 'package:lengo/model/category-model.dart';
import 'package:lengo/model/lesson-model.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/widgets/alert.dart';
import 'package:lengo/widgets/btn-main.dart';
import 'level-one.dart';
import 'level-three.dart';
import 'level-two.dart';
import 'package:lengo/widgets/loader.dart';

class Level extends StatefulWidget {

  final CategoryModel categoryModel;

  const Level({Key key, this.categoryModel}) : super(key: key);

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {

  AudioCache audioCache;
  AudioPlayer audioPlayer;

  int activeLevel = 0;
  bool isAnsweredCorrect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<LessonModel>>(
        stream: FirebaseManger.shard.getLessonByCategoryUid(uidCategory: widget.categoryModel.uid),
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            LessonModel lesson = snapshot.data[widget.categoryModel.currentlyLevel == null ? 0 : widget.categoryModel.currentlyLevel];

            List<Widget> levels = [LevelOne(items: lesson.itemsStageOne, uidCorrectAnswer: lesson.uidCorrectAnswerStageOne, handlerOnTap: (isCorrectAnswer) {
              _runAudio(isCorrect: isCorrectAnswer);
              if (isCorrectAnswer) {
                isAnsweredCorrect = true;
              }
            },), LevelTwo(items: lesson.listStageTwo, handlerOnTap: (isComplete, isCorrectAnswer) {
              _runAudio(isCorrect: isCorrectAnswer);
              if (isComplete) {
                isAnsweredCorrect = true;
              }
            },), LevelThree(handlerOnChangeText: (value) {
              if (value == lesson.correctAnswerStageThree) {
                isAnsweredCorrect = true;
              }
            },)];

            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * (60 / 812)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.1),
                                  offset: Offset(0, 0),
                                  blurRadius: 5,
                                  spreadRadius: 3)
                            ],
                          ),
                          child: Icon(Icons.close, color: "#8D94A6".toHexa()),
                        ),
                      ),
                      Text("${activeLevel + 1}/3", style: TextStyle(fontSize: 16, color: "#828282".toHexa(),),)
                    ],
                  ),
                  SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                      color: "#DFE8E9".toHexa(),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Row(
                          children: [
                            Container(
                              width: (constraints.maxWidth / (3 - activeLevel)),
                              height: 10,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(activeLevel == 0 ? "Choose the correct translation" : activeLevel == 1 ? "Tap the pairs" : "Translate sentence", style: TextStyle(color: "#7E8494".toHexa(), fontSize: 16,),),
                  Column(
                    children: [
                      SizedBox(height: 35),
                      Visibility(
                        visible: activeLevel != 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(activeLevel == 2 ? "Can you repeat please." : "", style: TextStyle(color: "#242833".toHexa(), fontSize: 18, fontWeight: FontWeight.w400,),),
                            InkWell(
                              onTap: () => _btnRunAudio(text: activeLevel == 0 ? lesson.audioStageOne : lesson.audioStageThree),
                              child: Container(
                                width: 35,
                                height: 35,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.1),
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        spreadRadius: 3)
                                  ],
                                ),
                                child: SvgPicture.asset(Assets.shared.icSpeaker, color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: levels[activeLevel]),
                ],
              ),
            );
          } else {
            return Center(child: loader(context));
          }

        }
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: BtnMain(title: "Continue", onTap: () => _btnContinue(context)),
      ),
    );
  }

  _btnRunAudio({ @required String text }) {
    _readText(text: text);
    // FirebaseManger.shard.addCategory(image: "", uidLanguage: "QPZUHU1CJwi5ScVniP8I", name: "", levelsCount: 0);
    // FirebaseManger.shard.addLanguage(name: "", image: "");
    // FirebaseManger.shard.addLesson(uidLesson: "dB2LD2bEIJbp1G6UMGqk", level: 2, audioStageOne: "coconut", itemsStageOne: ["MsUmICO7qfFAt7vnoCUP", "WCKUojcU0P9DjhMP91CY", "TEbNsKum0NENiubG7JwF", "CUxnEkqwSGsaqjunnD5x"], uidCorrectAnswerStageOne: "MsUmICO7qfFAt7vnoCUP", listStageTwo: ["apricot : مشمش", "coconut : جوز هند", "watermelon : بطيخ", "walnut : عين جمل", "cherry : كرز", "pomegranate : رمان"], audioStageThree: "pomegranate", correctAnswerStageThree: "رمان");
    // FirebaseManger.shard.addOptionLesson(uidLesson: "", title: "", image: "");
  }

  _btnContinue(context) {
    if (!isAnsweredCorrect) {
      showAlertDialog(context, title: "Error", message: "Please answer the correct answer", titleBtnOne: "Close", showBtnTwo: false, actionBtnOne: () {
        Navigator.of(context).pop();
      });
      return;
    }

    FirebaseManger.shard.increaseScore();

    if (activeLevel < 2) {
      isAnsweredCorrect = false;
      setState(() {
        activeLevel += 1;
      });
    } else {
      _runAudio(isCorrect: true);
      FirebaseManger.shard.addLevelComplete(uidCategory: widget.categoryModel.uid);
      Navigator.of(context).pushReplacementNamed("/FinishedLevel", arguments: widget.categoryModel);
    }
  }

  _runAudio({ @required bool isCorrect }) {
    audioCache.play(isCorrect ? Assets.shared.auCorrectAnswer : Assets.shared.auWrongAnswer);
  }

  _readText({ @required String text }) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
  }

}
