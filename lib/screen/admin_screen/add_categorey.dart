import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/view_admin_operation/auth_operation_admin.dart';

// ignore: must_be_immutable
class AddCategorey extends GetWidget<AuthOperationAdmin> {
  AddCategorey({Key key}) : super(key: key);

  String categoreyName;
  int countLevel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              controller.addCategorey(context, categoreyName, countLevel,
              controller.level, controller.uid_language, controller.image);
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        centerTitle: true,
        title: Text("Add Category"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () {
          controller.showAlert(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: GetBuilder<AuthOperationAdmin>(
                  init: AuthOperationAdmin(),
                  initState: (_) {},
                  builder: (_) {
                    return Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          width: double.infinity,
                          child: controller.image == null
                              ? Image.asset(
                                  "assets/images/icons/ic-english-square.png")
                              : Image.file(
                                  controller.image,
                                  fit: BoxFit.cover,
                                ),
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (e) {
                      categoreyName = e;
                    },
                    decoration: InputDecoration(labelText: "Categorey Name"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (e) {
                      countLevel = int.parse(e);
                    },
                    decoration: InputDecoration(labelText: "Count Level"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AuthOperationAdmin>(
                    init: AuthOperationAdmin(),
                    initState: (_) {
                     
                    },
                    builder: (_) {
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
                          controller.onChangeDropDownList(e);
                        },
                        value: controller.dropdownValue,
                        hint: Text(
                          "Choose Category Level",
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: <String>["Simple", "Meduim", "Hard"]
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
                    height: 16,
                  ),
                  GetBuilder<AuthOperationAdmin>(
                    init: AuthOperationAdmin(),
                    initState: (_) {
                     
                      controller.getLanguges();
                    },
                    builder: (_) {
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
                          controller.onChangeDropDownLanguge(e);
                        },
                        value: controller.dropdownValueLanguge,
                        hint: Text(
                          "Choose Language",
                          style: TextStyle(color: Colors.grey),
                        ),
                        items: ["English", "German", "Italian"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
