import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/screen/admin_screen/show_category_to_delete_question.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_update_question.dart';

// ignore: must_be_immutable
class UpdateQuestionScreen extends GetWidget<ViewUpdateQuestion> {
  UpdateQuestionScreen(
      {Key key,
      @required this.docId,
      @required this.audioStageOne,
      @required this.audioStageThree,
      @required this.correctAnswerStageThree,
      @required this.level,
      @required this.listStageTwo,
      @required this.answerIds,
      @required this.correctAnswerId})
      : super(key: key);

  final String docId;

  String audioStageOne;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String audioStageThree;
  String correctAnswerStageThree;

  final String level;
  final String listStageTwo;
  final String answerIds;
  final String correctAnswerId;
  String firstWordInArabid;
  String firstWordInEnglish;
  String secondWordInArabid;
  String secondWordInEnglish;
  String thirdWordInArabid;
  String thirdWordInEnglish;
  String fourthWordInArabid;
  String fourthWordInEnglish;
  String fifthWordInArabid;
  String fifthWordInEnglish;
  String sexthWordInArabid;
  String sexthWordInEnglish;
  String listTwoFirebaseFormat;
  List<String> idsList;
  String tOne;

  String IdFirstOption;
  String IdSecondOption;

  String IdThirdOption;
  String IdFourthOption;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewUpdateQuestion>(
      init: ViewUpdateQuestion(),
      initState: (_) {
        print("initState");
        List<String> myList = listStageTwo.split(", ");

        idsList = answerIds.split(", ");

        controller.getFirstOption(idsList[0]);
        controller.getSecondOption(idsList[1]);
        controller.getThirdOption(idsList[2]);
        controller.getFourthOption(idsList[3]);

        firstWordInArabid =
            myList[0].substring(0, myList[0].indexOf(":")).trim();

        firstWordInEnglish = myList[0]
            .substring(myList[0].lastIndexOf(":") + 1, myList[0].length)
            .trim();

        secondWordInArabid =
            myList[1].substring(0, myList[1].indexOf(":")).trim();
        secondWordInEnglish = myList[1]
            .substring(myList[1].lastIndexOf(":") + 1, myList[1].length)
            .trim();

        thirdWordInArabid =
            myList[2].substring(0, myList[2].indexOf(":")).trim();
        thirdWordInEnglish = myList[2]
            .substring(myList[2].lastIndexOf(":") + 1, myList[2].length)
            .trim();

        fourthWordInArabid =
            myList[3].substring(0, myList[3].indexOf(":")).trim();
        fourthWordInEnglish = myList[3]
            .substring(myList[3].lastIndexOf(":") + 1, myList[3].length)
            .trim();

        fifthWordInArabid =
            myList[4].substring(0, myList[4].indexOf(":")).trim();
        fifthWordInEnglish = myList[4]
            .substring(myList[4].lastIndexOf(":") + 1, myList[4].length)
            .trim();

        sexthWordInArabid =
            myList[5].substring(0, myList[5].indexOf(":")).trim();
        sexthWordInEnglish = myList[5]
            .substring(myList[5].lastIndexOf(":") + 1, myList[5].length)
            .trim();

        tOne = controller.titleOne;
      },
      builder: (v) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  listTwoFirebaseFormat =
                      "$firstWordInEnglish : $firstWordInArabid, $secondWordInEnglish : $secondWordInArabid, $thirdWordInEnglish : $thirdWordInArabid, $fourthWordInEnglish : $fourthWordInArabid, $fifthWordInEnglish : $fifthWordInArabid, $sexthWordInEnglish : $sexthWordInArabid";

                  print("firstWordOInEnglish In $firstWordInEnglish");
                  print("listTwoFirebaseFormat $listTwoFirebaseFormat");
                  v.updateQuestion(
                      context,
                      docId,
                      audioStageOne,
                      audioStageThree,
                      correctAnswerStageThree,
                      listTwoFirebaseFormat);
                     v.updateFirstOption(
                      idsList[0], v.titleOne, controller.imagePathOne);

                      v.updateSecondOption(
                      idsList[1], v.titleTwo, controller.imagePathTwo);

                      v.updateThirdOption(
                      idsList[2], v.titleThree, controller.imagePathThree);

                      v.updateFourthOption(
                      idsList[3], v.titleFour, controller.imagePathFour);
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
            centerTitle: true,
            title: Text("Update Question"),
          ),
          body: GetBuilder<ViewUpdateQuestion>(
            init: ViewUpdateQuestion(),
            initState: (_) {},
            builder: (_) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text("Stage One"),
                    GetBuilder<ViewUpdateQuestion>(
                      init: ViewUpdateQuestion(),
                      initState: (_) {},
                      builder: (value) {
                        return TextFormField(
                          initialValue: audioStageOne,
                          onChanged: (e) {
                            audioStageOne = e;
                          },
                          decoration: InputDecoration(
                              labelText: "Enter Audio Stage One"),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GetBuilder<ViewUpdateQuestion>(
                              init: ViewUpdateQuestion(),
                              initState: (_) {},
                              builder: (v) {
                                return InkWell(
                                  onTap: () {
                                    v.showAlertIamgeSourceOne(context, 1);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        child: v.imageOne == null
                                            ? Image.network(
                                                controller.imagePathOne,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                controller.imageOne,
                                                fit: BoxFit.cover,
                                              ),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        height: 100,
                                        width: 100,
                                      ),
                                    
                                    
                                    ],
                                  ),
                                );
                              },
                            ),
                            Container(
                                width: 100,
                                child: GetBuilder<ViewUpdateQuestion>(
                                  init: ViewUpdateQuestion(),
                                  initState: (_) {
                                    print("controller tOne ${tOne}");
                                  },
                                  builder: (con) {
                                    return TextFormField(
                                      controller: TextEditingController(
                                          text: con.titleOne),
                                      onChanged: (e) {
                                        con.titleOne = e;
                                        print("con.titleOne ${con.titleOne}");
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Item Name"),
                                    );
                                  },
                                ))
                          ],
                        ),
                        GetBuilder<ViewUpdateQuestion>(
                          init: ViewUpdateQuestion(),
                          initState: (_) {},
                          builder: (val) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    v.showAlertIamgeSourceOne(context, 2);
                                    print("${controller.imagePathOne}");
                                    print("${controller.titleOne}");
                                  },
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    child: v.imagetwo == null
                                        ? Image.network(
                                            controller.imagePathTwo,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            controller.imagetwo,
                                            fit: BoxFit.cover,
                                          ),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                Container(
                                    width: 100,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                          text: controller.titleTwo),
                                      onChanged: (e) {
                                        controller.titleTwo = e;
                                        controller.update();
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Item Name"),
                                    ))
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GetBuilder<ViewUpdateQuestion>(
                              init: ViewUpdateQuestion(),
                              initState: (_) {},
                              builder: (value) {
                                return InkWell(
                                  onTap: () {
                                    value.showAlertIamgeSourceOne(context, 3);
                                  },
                                  child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        child: v.imagethree == null
                                            ? Image.network(
                                                controller.imagePathThree,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                controller.imagethree,
                                                fit: BoxFit.cover,
                                              ),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        height: 100,
                                        width: 100,
                                      ),
                                );
                              },
                            ),
                            Container(
                                width: 100,
                                child: TextFormField(
                                  controller: TextEditingController(text: controller.titleThree),
                                  onChanged: (e) {
                                    controller.titleThree = e;
                                    controller.update();
                                  },
                                  decoration:
                                      InputDecoration(labelText: "Item Name"),
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            GetBuilder<ViewUpdateQuestion>(
                              init: ViewUpdateQuestion(),
                              initState: (_) {},
                              builder: (val) {
                                return InkWell(
                                  onTap: () {
                                    val.showAlertIamgeSourceOne(context, 4);
                                  },
                                  child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        child: v.imagefour == null
                                            ? Image.network(
                                                controller.imagePathFour,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                controller.imagefour,
                                                fit: BoxFit.cover,
                                              ),
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        height: 100,
                                        width: 100,
                                      ),
                                );
                              },
                            ),
                            Container(
                                width: 100,
                                child: TextFormField(
                                  controller: TextEditingController(text: controller.titleFour),
                                  onChanged: (e) {
                                    controller.titleFour = e;
                                    controller.update();
                                  },
                                  decoration:
                                      InputDecoration(labelText: "Item Name"),
                                ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    GetBuilder<ViewUpdateQuestion>(
                      init: ViewUpdateQuestion(),
                      initState: (_) {},
                      builder: (dropDownValue) {
                        return DropdownBelow(
                          itemWidth: MediaQuery.of(context).size.width,
                          itemTextstyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          boxTextstyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          boxPadding: EdgeInsets.fromLTRB(13, 12, 13, 12),
                          boxWidth: double.infinity,
                          boxHeight: 45,
                          boxDecoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
                              )),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          onChanged: (e) {
                            dropDownValue.changeLevel(e);
                          },
                          value: dropDownValue.level,
                          hint: Text("${dropDownValue.level}"),
                          items: <String>["1", "2", "3"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Text("Stage Two"),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          initialValue: firstWordInEnglish,
                          onChanged: (e) {
                            firstWordInEnglish = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In English"),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: TextFormField(
                          initialValue: firstWordInArabid,
                          onChanged: (e) {
                            print(
                                "firstWordInEnglish In Change $firstWordInArabid");
                            firstWordInArabid = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In Arabic"),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          initialValue: secondWordInEnglish,
                          onChanged: (e) {
                            secondWordInEnglish = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In English"),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: TextFormField(
                          initialValue: secondWordInArabid,
                          onChanged: (e) {
                            secondWordInArabid = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In Arabic"),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          initialValue: thirdWordInEnglish,
                          onChanged: (e) {
                            thirdWordInEnglish = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In English"),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: TextFormField(
                          initialValue: thirdWordInArabid,
                          onChanged: (e) {
                            thirdWordInArabid = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In Arabic"),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          initialValue: fourthWordInEnglish,
                          onChanged: (e) {
                            fourthWordInEnglish = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In English"),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: TextFormField(
                          initialValue: fourthWordInArabid,
                          onChanged: (e) {
                            fourthWordInArabid = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In Arabic"),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          initialValue: fifthWordInEnglish,
                          onChanged: (e) {
                            fifthWordInEnglish = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In English"),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: TextFormField(
                          initialValue: fifthWordInArabid,
                          onChanged: (e) {
                            fifthWordInArabid = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In Arabic"),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          initialValue: sexthWordInEnglish,
                          onChanged: (e) {
                            sexthWordInEnglish = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In English"),
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: TextFormField(
                          initialValue: sexthWordInArabid,
                          onChanged: (e) {
                            sexthWordInArabid = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Word In Arabic"),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Text("Stage Three"),
                    GetBuilder<ViewUpdateQuestion>(
                      init: ViewUpdateQuestion(),
                      initState: (_) {},
                      builder: (v) {
                        return TextFormField(
                          initialValue: audioStageThree,
                          onChanged: (e) {
                            audioStageThree = e;
                          },
                          decoration:
                              InputDecoration(labelText: "Audio Stage Three"),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      initialValue: correctAnswerStageThree,
                      onChanged: (e) {
                        correctAnswerStageThree = e;
                      },
                      decoration: InputDecoration(
                          labelText: "Correct Answer Stage Three"),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ));
            },
          ),
        );
      },
    );
  }
}
