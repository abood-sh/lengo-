import 'dart:ui';
import 'package:flutter/material.dart';

extension StringExtensions on String {

  bool isValidEmail() => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  bool isValidPassword() => this.length >= 6 && this.length <= 15;

  Color toHexa() {
    final buffer = StringBuffer();
    if (this.length == 6 || this.length == 7) buffer.write('ff');
    buffer.write(this.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

}

extension TextEditingControllerExtensions on TextEditingController {

  isEmptyValue() => this.text.trim().length != 0 && this.text.trim() != null && this.text.trim() != '';

}

extension ScaffoldStateExtensions on GlobalKey<ScaffoldState> {

  showTosta({ @required message, isError = false }) {

    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
      backgroundColor: isError ? Colors.red : Colors.green,
    );

    try {
      this.currentState.showSnackBar(snackBar);
    } catch(e) {

    }

  }

}
