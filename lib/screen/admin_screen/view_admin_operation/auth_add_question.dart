import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthAddQuestion extends GetxController{

  File imageOne;
  File imagetwo;
  File imagethree;
  File imagefour;


final picker = ImagePicker();
 

Future getFirstImage(ImageSource source) async {
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

void showAlertIamgeSourceOne(BuildContext context){
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
void showAlertIamgeSourceTwo(BuildContext context){
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
void showAlertIamgeSourceThree(BuildContext context){
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
void showAlertIamgeSourceFour(BuildContext context){
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

}