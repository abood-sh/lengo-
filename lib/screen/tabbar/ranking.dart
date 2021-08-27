import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lengo/enums/gender.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/utils/user_profile.dart';
import 'package:lengo/widgets/loader.dart';

class Ranking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: UserProfile.shared.getUser(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return Center(child: loader(context));
        }

        UserModel currentUser = snapshot.data;

        return StreamBuilder<List<UserModel>>(
            stream: FirebaseManger.shard.getAllUsers(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {

                List<UserModel> items = snapshot.data;

                return Container(
                  padding: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * (362 / 812),
                        child: Stack(
                          children: [
                            SvgPicture.asset(Assets.shared.bgStarts, fit: BoxFit.fill,),
                            Container(
                              padding: EdgeInsets.all(20),
                              height: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  items.length > 2 ? _headerItem(image: items[2].gender == Gender.MALE ? Assets.shared.icMale : Assets.shared.icFemale, number: "3", color: "#0A7E89") : SizedBox(),
                                  items.length > 0 ? _headerItem(image: items[0].gender == Gender.MALE ? Assets.shared.icMale : Assets.shared.icFemale, number: "1", color: "#F1B640", isCenter: true) : SizedBox(),
                                  items.length > 1 ? _headerItem(image: items[1].gender == Gender.MALE ? Assets.shared.icMale : Assets.shared.icFemale, number: "2", color: "#D46795") : SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: "#F2F2F2".toHexa(),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return _item(index: index, user: items[index], uidCurrentUser: currentUser.uid);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: loader(context));
              }

            }
        );
      },
    );
  }

  _headerItem({ @required String image, @required String number, @required String color, bool isCenter = false }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(visible: isCenter, child: SvgPicture.asset(Assets.shared.icCrown)),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(top: 10),
          width: isCenter ? 134 : 72,
          height: isCenter ? 134 : 72,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: color.toHexa(), width: 3),
            shape: BoxShape.circle,
          ),
          child: Center(child: SvgPicture.asset(image, height: double.infinity,)),
        ),
        Container(
          width: 32,
          height: 32,
          transform: Matrix4.translationValues(0.0, -20, 0.0),
          decoration: BoxDecoration(
            color: color.toHexa(),
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
          child: Center(child: Text(number, style: TextStyle(color: Colors.white, fontSize: 16),),),
        ),
      ],
    );
  }

  _item({ @required int index, @required UserModel user, @required String uidCurrentUser }) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: user.uid == uidCurrentUser ? "#F1B640".toHexa() : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Text((index + 1).toString(), style: TextStyle(color: user.uid == uidCurrentUser ? Colors.white : "#333333".toHexa(), fontSize: 16, fontWeight: FontWeight.w600),),
              SizedBox(width: 2),
              // Text("st", style: TextStyle(color: user.uid == uidCurrentUser ? Colors.white : "#333333".toHexa(), fontSize: 14),),
            ],
          ),
          SizedBox(width: 23,),
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(user.gender == Gender.MALE ? Assets.shared.icMale : Assets.shared.icFemale, fit: BoxFit.cover,),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: user.uid == uidCurrentUser ? Colors.white : "#333333".toHexa()),),
                  SizedBox(height: 5,),
                  Text("Score: ${user.score}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: user.uid == uidCurrentUser ? Colors.white : "#333333".toHexa()),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
