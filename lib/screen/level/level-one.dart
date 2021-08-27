import 'package:flutter/material.dart';
import 'package:lengo/model/options-lesson-model.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/widgets/loader.dart';

class LevelOne extends StatefulWidget {
  
  final List<String> items;
  final String uidCorrectAnswer;
  final Function handlerOnTap;

  const LevelOne({Key key, this.items, this.uidCorrectAnswer, this.handlerOnTap}) : super(key: key);

  @override
  _LevelOneState createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {

  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 26,),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              Container(
                width: constraints.maxWidth / 3,
                height: 1,
                color: "#D3D7E0".toHexa(),
              ),
              Expanded(child: Text("in English", textAlign: TextAlign.center, style: TextStyle(color: "#7E8494".toHexa(), fontSize: 15,),)),
              Container(
                width: constraints.maxWidth / 3,
                height: 1,
                color: "#D3D7E0".toHexa(),
              ),
            ],
          );
        }),
        Expanded(
          child: GridView.count(
            padding: EdgeInsets.symmetric(vertical: 20),
            crossAxisCount: 2,
            children: List.generate(widget.items.length, (index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: selectedItem == widget.items[index] ? Theme.of(context).accentColor : Colors.transparent),
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
                  onTap: () {
                    widget.handlerOnTap(widget.items[index] == widget.uidCorrectAnswer);
                    setState(() {
                      selectedItem = widget.items[index];
                    });
                  },
                  child: StreamBuilder<OptionsLessonModel>(
                    stream: FirebaseManger.shard.getOtionLessonByUid(uid: widget.items[index]),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {

                        OptionsLessonModel item = snapshot.data;

                        return Column(
                          children: [
                            Expanded(child: Image.network(item.image)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              item.title,
                              style:
                              TextStyle(color: "#333333".toHexa(), fontSize: 18),
                            )
                          ],
                        );
                      } else {
                        return Center(child: loader(context),);
                      }

                    }
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
