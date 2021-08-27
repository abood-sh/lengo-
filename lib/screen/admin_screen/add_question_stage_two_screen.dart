import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_question_stage_two.dart';

// ignore: must_be_immutable
class AddQuestionStageTwoScreen extends GetWidget<ViewQusetionStageTwo> {
  AddQuestionStageTwoScreen({Key key, @required this.docId}) : super(key: key);

  final String docId;

  String firstWordInEnglish;
  String firstWordInArabic;

  String secondWordInEnglish;
  String secondWordInArabic;

  String thirdWordInEnglish;
  String thirdWordInArabic;

  String forthWordInEnglish;
  String forthWordInArabic;

  String fifthhWordInEnglish;
  String fifthWordInArabic;

  String sexthWordInEnglish;
  String sexthWordInArabic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewQusetionStageTwo>(
      init: ViewQusetionStageTwo(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Add Question Stage Two"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
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
                        onChanged: (e) {
                          firstWordInArabic = e;
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
                        onChanged: (e) {
                          secondWordInArabic = e;
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
                        onChanged: (e) {
                          thirdWordInArabic = e;
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
                        onChanged: (e) {
                         forthWordInEnglish = e;
                        },
                        decoration:
                            InputDecoration(labelText: "Word In English"),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: TextFormField(
                        onChanged: (e) {
                          forthWordInArabic = e;
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
                        onChanged: (e) {
                         fifthhWordInEnglish = e;
                        },
                        decoration:
                            InputDecoration(labelText: "Word In English"),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: TextFormField(
                        onChanged: (e) {
                          fifthWordInArabic = e;
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
                        onChanged: (e) {
                          sexthWordInArabic = e;
                        },
                        decoration:
                            InputDecoration(labelText: "Word In Arabic"),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  
                  const SizedBox(
                    height: 32,
                  ),
                  GetBuilder<ViewQusetionStageTwo>(
                    init: ViewQusetionStageTwo(),
                    initState: (_) {},
                    builder: (_) {
                      return ElevatedButton(
                          onPressed: () {
                            controller.AddStageTwo(
                                context,
                                docId,
                                firstWordInEnglish,
                                firstWordInArabic,
                                secondWordInEnglish,
                                secondWordInArabic,
                                thirdWordInEnglish,
                                thirdWordInArabic,
                                forthWordInEnglish,
                                forthWordInArabic,
                                fifthhWordInEnglish,
                                fifthWordInArabic,
                                sexthWordInEnglish,
                                sexthWordInArabic);
                          },
                          child: Text("Next"));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
