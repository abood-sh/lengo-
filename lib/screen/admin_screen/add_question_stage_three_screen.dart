import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/view_add_question_stage_three.dart';

// ignore: must_be_immutable
class AddQuestionStageThreeScreen extends GetWidget<ViewAddQuestionStageThree> {
  AddQuestionStageThreeScreen({Key key, @required this.docId})
      : super(key: key);

  final String docId;

  String audioStageThree;
  String correctAnswerStageThree;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Question Stage Three"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                onChanged: (e) {
                  audioStageThree = e;
                },
                decoration: InputDecoration(labelText: "Audio Stage Three"),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                onChanged: (e) {
                  correctAnswerStageThree = e;
                },
                decoration:
                    InputDecoration(labelText: "Correct Answer Stage Three"),
              ),
              const SizedBox(
                height: 12,
              ),
              GetBuilder<ViewAddQuestionStageThree>(
                init: ViewAddQuestionStageThree(),
                initState: (_) {},
                builder: (_) {
                  return ElevatedButton(
                      onPressed: () {
                        controller.addStageThree(context, docId, audioStageThree, correctAnswerStageThree);
                      }, child: Text("Finish"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
