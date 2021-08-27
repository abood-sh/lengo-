import 'dart:io';

import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/auth_operation_admin.dart';

// ignore: must_be_immutable
class AddQuestionScreen extends GetWidget<AuthOperationAdmin> {
  AddQuestionScreen({Key key, @required this.docId}) : super(key: key);

  final String docId;
  String audio_stage_one;
  String firstItemName;
  String secondItemName;
  String thirdItemName;
  String fourthItemName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Question"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                onChanged: (e) {
                  audio_stage_one = e;
                },
                decoration: InputDecoration(labelText: "Enter Audio Stage One"),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GetBuilder<AuthOperationAdmin>(
                        init: AuthOperationAdmin(),
                        initState: (_) {},
                        builder: (val) {
                          return InkWell(
                            onTap: () {
                              val.showAlertIamgeSourceOne(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  child: val.imageOne == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "assets/images/question.svg"),
                                        )
                                      : Image.file(
                                          val.imageOne,
                                          fit: BoxFit.cover,
                                        ),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 100,
                                  width: 100,
                                ),
                                Checkbox(
                                    value: val.firstCheckBox,
                                    onChanged: (e) {
                                      val.changeFirst(e, 1);
                                    })
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                          width: 100,
                          child: TextFormField(
                            onChanged: (e) {
                              firstItemName = e;
                            },
                            decoration: InputDecoration(labelText: "Item Name"),
                          ))
                    ],
                  ),
                  GetBuilder<AuthOperationAdmin>(
                    init: AuthOperationAdmin(),
                    initState: (_) {},
                    builder: (value) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              value.showAlertIamgeSourceTwo(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  child: value.imagetwo == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "assets/images/question.svg"),
                                        )
                                      : Image.file(
                                          value.imagetwo,
                                          fit: BoxFit.cover,
                                        ),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 100,
                                  width: 100,
                                ),
                                Checkbox(
                                    value: value.secondCheckBox,
                                    onChanged: (e) {
                                      value.changeFirst(e, 2);
                                    })
                              ],
                            ),
                          ),
                          Container(
                              width: 100,
                              child: TextFormField(
                                onChanged: (e) {
                                  secondItemName = e;
                                },
                                decoration:
                                    InputDecoration(labelText: "Item Name"),
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
                      GetBuilder<AuthOperationAdmin>(
                        init: AuthOperationAdmin(),
                        initState: (_) {},
                        builder: (v) {
                          return InkWell(
                            onTap: () {
                              v.showAlertIamgeSourceThree(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  child: v.imagethree == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "assets/images/question.svg"),
                                        )
                                      : Image.file(
                                          v.imagethree,
                                          fit: BoxFit.cover,
                                        ),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 100,
                                  width: 100,
                                ),
                                Checkbox(
                                    value: v.thirdheCkBox,
                                    onChanged: (e) {
                                      v.changeFirst(e, 3);
                                    })
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                          width: 100,
                          child: TextFormField(
                            onChanged: (e) {
                              thirdItemName = e;
                            },
                            decoration: InputDecoration(labelText: "Item Name"),
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      GetBuilder<AuthOperationAdmin>(
                        init: AuthOperationAdmin(),
                        initState: (_) {},
                        builder: (val) {
                          return InkWell(
                            onTap: () {
                              val.showAlertIamgeSourceFour(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  child: val.imagefour == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "assets/images/question.svg"),
                                        )
                                      : Image.file(
                                          val.imagefour,
                                          fit: BoxFit.cover,
                                        ),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 100,
                                  width: 100,
                                ),
                                Checkbox(
                                    value: val.fourthCheckBox,
                                    onChanged: (e) {
                                      val.changeFirst(e, 4);
                                    })
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                          width: 100,
                          child: TextFormField(
                            onChanged: (e) {
                              fourthItemName = e;
                            },
                            decoration: InputDecoration(labelText: "Item Name"),
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              GetBuilder<AuthOperationAdmin>(
                init: AuthOperationAdmin(),
                initState: (_) {},
                builder: (vall) {
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
                          bottom: BorderSide(width: 1, color: Colors.grey),
                        )),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    onChanged: (e) {
                      vall.changeDropDown(e);
                    },
                    value: vall.dropDown,
                    hint: Text(
                      "Choose Qusetion Level",
                      style: TextStyle(color: Colors.grey),
                    ),
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
              GetBuilder<AuthOperationAdmin>(
                init: AuthOperationAdmin(),
                initState: (_) {},
                builder: (c) {
                  return ElevatedButton(
                    child: Text("Next"),
                    onPressed: () {
                      controller.addQuestionStepOne(
                          context,
                          audio_stage_one,
                          int.parse(controller.dropDown),
                          OptionsLessonModel(
                              title: firstItemName,
                              image: controller.imageOnePath),
                          OptionsLessonModel(
                              title: secondItemName,
                              image: controller.imagetwoPath),
                          OptionsLessonModel(
                              title: thirdItemName,
                              image: controller.imagethreePath),
                          OptionsLessonModel(
                              title: fourthItemName,
                              image: controller.imagefourPath),
                          docId);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
