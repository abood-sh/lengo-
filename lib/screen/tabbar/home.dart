import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lengo/enums/level.dart';
import 'package:lengo/model/category-model.dart';
import 'package:lengo/model/level-complete-model.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/screen/auth.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/utils/user_profile.dart';
import 'package:lengo/widgets/alert.dart';
import 'package:lengo/widgets/drawer.dart';
import 'package:lengo/widgets/loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String rate = "";

  Future<UserModel> user = FirebaseManger.shard.getUserByUid(uid: FirebaseAuth.instance.currentUser.uid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * (41 / 812),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * (60 / 812),
              decoration: BoxDecoration(
                color: "#DFE8E9".toHexa(),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(Assets.shared.icEnglish),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "English",
                        style:
                            TextStyle(color: "#4F4F4F".toHexa(), fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      FutureBuilder<UserModel>(
                        future: FirebaseManger.shard.getUserByUid(uid: FirebaseAuth.instance.currentUser.uid),
                        builder: (context, snapshot) {
                          return Visibility(
                            visible: (rate != "" && double.parse(rate) >= 70 && snapshot.hasData && snapshot.data.currentLevel != Level.ADVANCED),
                            child: FlatButton(
                              onPressed: () async {
                                bool isSuccess = await FirebaseManger.shard.increaseLevel();

                                if (isSuccess) {
                                  setState(() {
                                    this.user = FirebaseManger.shard.getUserByUid(uid: FirebaseAuth.instance.currentUser.uid);
                                  });
                                  _getRate();
                                }

                              },
                              child: Text(
                                "Next Level",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16),
                              ),
                            ),
                          );
                        }
                      ),
                      Text(
                        "$rate%",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<UserModel>(
                future: this.user,
                builder: (context, snapshot) {

                  if (snapshot.hasData) {

                    UserModel user = snapshot.data;

                    return StreamBuilder<List<CategoryModel>>(
                        stream: FirebaseManger.shard.getCategoryByLanguage(
                            uidLanguage: user.uidLanguage),
                        builder: (context, snapshot) {

                          if (snapshot.hasData) {

                            List<CategoryModel> items = [];

                            for (var item in snapshot.data) {
                              if (user.currentLevel == item.level) {
                                items.add(item);
                              }
                            }

                            return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return _item(context, items[index]);
                              },
                            );
                          } else {
                            return Center(child: loader(context));
                          }
                        });
                  }
                  return SizedBox();
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(context, CategoryModel item) {
    return StreamBuilder<List<LevelCompleteModel>>(
        stream: FirebaseManger.shard.getCompleteLevel(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (var level in snapshot.data) {
              if (level.uidCategory == item.uid) {
                item.currentlyLevel = level.level;
                break;
              }
            }
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              onTap: () async {
                if (item.levelsCount == 0) {
                  showAlertDialog(context,
                      title: "Error",
                      message: "No lessons added yet",
                      titleBtnOne: "Close",
                      showBtnTwo: false, actionBtnOne: () {
                    Navigator.of(context).pop();
                  });
                  return;
                }

                if (item.currentlyLevel == (item.levelsCount)) {
                  showAlertDialog(context,
                      title: "Error",
                      message: "You have finished this level",
                      titleBtnOne: "Close",
                      showBtnTwo: false, actionBtnOne: () {
                    Navigator.of(context).pop();
                  });
                  return;
                }

                await Navigator.of(context)
                    .pushNamed("/Level", arguments: item);
                _getRate();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Image.network(item.image),
                            Visibility(
                              visible: item.currentlyLevel == item.levelsCount,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  transform: Matrix4.translationValues(5, 3, 0),
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        item.name,
                        style:
                            TextStyle(color: "#242833".toHexa(), fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${item.currentlyLevel == null ? 0 : item.currentlyLevel}/${item.levelsCount}",
                        style:
                            TextStyle(color: "#242833".toHexa(), fontSize: 15),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Container(
                        width: 4,
                        height: 60,
                        decoration: BoxDecoration(
                          color: "#E4E9F5".toHexa(),
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight *
                                    (item.currentlyLevel == null
                                        ? 0
                                        : item.currentlyLevel /
                                            item.levelsCount),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getRate() async {

    UserModel user = await this.user;

    double ratting = await FirebaseManger.shard
        .getUserCompletionPercentage(uidLanguage: user.uidLanguage);

    setState(() {
      rate = ratting.toString();
    });
  }
}
