import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, { String title = "", String message = "" , String titleBtnOne = "Ok", String titleBtnTwo = "Close", Function actionBtnOne, Function actionBtnTwo, bool showBtnOne = true, bool showBtnTwo = true}) {

  Widget btnOne = FlatButton(
    child: Text(titleBtnOne),
    onPressed: actionBtnOne,
  );

  Widget btnTwo = FlatButton(
    child: Text(titleBtnTwo),
    onPressed: actionBtnTwo,
  );

  AlertDialog alert = AlertDialog(
    title: Text(title, style: TextStyle(color: Theme.of(context).primaryColor),),
    content: Text(message),
    actions: [
      Visibility(visible: showBtnOne, child: btnOne),
      Visibility(visible: showBtnTwo, child: btnTwo),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}