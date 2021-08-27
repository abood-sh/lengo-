import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lengo/enums/level.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/utils/extensions.dart';

class SelectLevel extends StatelessWidget {

  final LanguageModel language;
  final Level activeItem;
  final Function handlerOnTap;

  const SelectLevel({Key key, this.language, this.activeItem, this.handlerOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Level> items = [Level.BEGINNER, Level.INTERMEDIATE, Level.ADVANCED];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 38, vertical: 10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: (activeItem != null && activeItem.index == index) ? Theme.of(context).accentColor : Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () => handlerOnTap(items[index]),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * (50 / 375),
                  height: MediaQuery.of(context).size.width * (50 / 375),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.network(language.image),
                ),
                SizedBox(width: 38,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_convertItemToString(items[index]), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tenses", style: TextStyle(fontSize: 14, color: "#606060".toHexa()),),
                            SizedBox(height: 6,),
                            Text("Listening", style: TextStyle(fontSize: 14, color: "#606060".toHexa()),),
                            SizedBox(height: 6,),
                            Text("Reading", style: TextStyle(fontSize: 14, color: "#606060".toHexa()),),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Writing", style: TextStyle(fontSize: 14, color: "#606060".toHexa()),),
                            SizedBox(height: 6,),
                            Text("Speaking", style: TextStyle(fontSize: 14, color: "#606060".toHexa()),),
                            SizedBox(height: 6,),
                            Text("Test", style: TextStyle(fontSize: 14, color: "#606060".toHexa()),),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String _convertItemToString(Level level) {
    switch (level) {
      case Level.BEGINNER:
        return "Beginner";
      case Level.INTERMEDIATE:
        return "Intermediate";
      case Level.ADVANCED:
        return "Advanced";
      default: return "";
    }
  }

}
