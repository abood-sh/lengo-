import 'package:flutter/material.dart';
import 'package:lengo/utils/extensions.dart';

class BtnBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: "#E0E0E0".toHexa(),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(Icons.arrow_back, color: "#4F4F4F".toHexa(),),
      ),
    );
  }
}
