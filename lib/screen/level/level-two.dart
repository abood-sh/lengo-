import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lengo/utils/extensions.dart';

class LevelTwo extends StatefulWidget {

  final List<String> items;
  final Function handlerOnTap;

  const LevelTwo({Key key, this.items, this.handlerOnTap}) : super(key: key);

  @override
  _LevelTwoState createState() => _LevelTwoState();
}

class _LevelTwoState extends State<LevelTwo> {

  List<String> listItemsOne = [];
  List<String> listItemsTwo = [];
  List<String> itemsComplate = [];

  int activeItemInListOne;
  int activeItemInListTwo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (String item in widget.items) {
      List<String> tempList = item.split(" : ");
      listItemsOne.add(tempList.first);
      listItemsTwo.add(tempList.last);
    }

    listItemsOne = shuffle(listItemsOne);
    listItemsTwo = shuffle(listItemsTwo);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _listItem(context, 0)),
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
        Expanded(child: _listItem(context, 1)),
      ],
    );
  }

  Widget _listItem(context, int listNumber) {

    List<String> tempList = listNumber == 0 ? listItemsOne : listItemsTwo;
    int selectedItem = listNumber == 0 ? activeItemInListOne : activeItemInListTwo;

    return GridView.count(
      padding: EdgeInsets.symmetric(vertical: 20),
      childAspectRatio: 1.8 / 1,
      crossAxisCount: 3,
      children: List.generate(tempList.length, (index) {
        return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: itemsComplate.contains(tempList[index]) ? Colors.transparent : index == selectedItem ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: itemsComplate.contains(tempList[index]) ? Colors.transparent : Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () {

              if (itemsComplate.contains(tempList[index])) {
                return;
              }

              setState(() {
                if (listNumber == 0) {
                  setState(() {
                    activeItemInListOne = index;
                  });
                } else {
                  setState(() {
                    activeItemInListTwo = index;
                  });
                }
              });

              if (activeItemInListOne != null && activeItemInListTwo != null) {

                bool isCorrect = widget.items.contains("${listItemsOne[activeItemInListOne]} : ${listItemsTwo[activeItemInListTwo]}");

                if (isCorrect) {
                  setState(() {
                    itemsComplate.add(listItemsOne[activeItemInListOne]);
                    itemsComplate.add(listItemsTwo[activeItemInListTwo]);
                  });
                }

                widget.handlerOnTap(itemsComplate.length == (listItemsOne.length + listItemsTwo.length), isCorrect);

                setState(() {
                  activeItemInListOne = null;
                  activeItemInListTwo = null;
                });
              }

            },
            child: Center(
              child: Text(tempList[index], style: TextStyle(fontSize: 15, color: index == selectedItem ? Colors.white : "#333333".toHexa(), decoration: itemsComplate.contains(tempList[index]) ? TextDecoration.lineThrough : TextDecoration.none,),),
            ),
          ),
        );
      }),
    );
  }

  List shuffle(List items) {
    var random = Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

}
