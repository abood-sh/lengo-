import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lengo/enums/gender.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';

class SelectGender extends StatelessWidget {
  final Gender activeItem;
  final Function handlerOnTap;

  const SelectGender({Key key, this.activeItem, this.handlerOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Gender> items = [Gender.MALE, Gender.FEMALE];

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.2,
      children: List.generate(
        items.length,
        (index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: ((activeItem != null &&
                                activeItem == Gender.values[index])
                            ? Theme.of(context).primaryColor
                            : "#EEEEEE".toHexa()),
                        radius: 10,
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: (activeItem != null &&
                                  activeItem == Gender.values[index])
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: SvgPicture.asset(items[index] == Gender.MALE
                          ? Assets.shared.icMale
                          : Assets.shared.icFemale)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    items[index] == Gender.MALE ? "Male" : "Female",
                    style: TextStyle(
                        color: (activeItem != null &&
                                activeItem == Gender.values[index])
                            ? "#333333".toHexa()
                            : "#999999".toHexa(),
                        fontSize: 18),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
