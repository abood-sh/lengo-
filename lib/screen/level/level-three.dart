import 'package:flutter/material.dart';
import 'package:lengo/utils/extensions.dart';

class LevelThree extends StatelessWidget {

  final Function handlerOnChangeText;

  const LevelThree({Key key, this.handlerOnChangeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * (45 / 812),),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Row(
                  children: [
                    Container(
                      width: constraints.maxWidth / 3,
                      height: 1,
                      color: "#D3D7E0".toHexa(),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      width: constraints.maxWidth / 3,
                      height: 1,
                      color: "#D3D7E0".toHexa(),
                    ),
                  ],
                );
              }),
          SizedBox(height: 35),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              textInputAction: TextInputAction.done,
              minLines: 3,
              maxLines: null,
              onChanged: (value) => handlerOnChangeText(value.trim()),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Here will be the Arabic Text for the\nTranslation",
                hintStyle: TextStyle(fontSize: 15, color: "#777777".toHexa()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
