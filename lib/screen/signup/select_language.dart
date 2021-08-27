import 'package:flutter/material.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/widgets/alert.dart';
import 'package:lengo/widgets/loader.dart';

class SelectLanguage extends StatelessWidget {

  final LanguageModel activeItem;
  final Function handlerOnTap;

  const SelectLanguage({Key key, this.activeItem, this.handlerOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LanguageModel>>(
      stream: FirebaseManger.shard.getAllLanguages(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          List<LanguageModel> items = snapshot.data;

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2 / 1,
            children: List.generate(items.length, (index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: (activeItem != null && activeItem.uid == items[index].uid) ? Theme.of(context).accentColor : Colors.transparent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () => {
                    if (items[index].isActive) {
                      handlerOnTap(items[index])
                    } else {
                      showAlertDialog(context, title: "Error", message: "This language is not enabled", titleBtnOne: "Close", showBtnTwo: false, actionBtnOne: () {
                        Navigator.of(context).pop();
                      }),
                    },

                  },
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(items[index].image, fit: BoxFit.cover,)
                      ),
                      SizedBox(width: 10,),
                      Text(items[index].name, style: TextStyle(color: "#666666".toHexa(), fontSize: 18),),
                    ],
                  ),
                ),
              );
            },
            ),);
        } else {
          return Center(child: loader(context));
        }

      }
    );
  }
}
