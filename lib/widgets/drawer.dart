import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lengo/enums/level.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/utils/user_profile.dart';
import 'package:lengo/widgets/loader.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * (57 / 812),),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Languages", style: TextStyle(fontSize: 20, color: "#242833".toHexa()),),
              ),
            ],
          ),
          SizedBox(height: 32,),
          Expanded(
            child: FutureBuilder<UserModel>(
              future: UserProfile.shared.getUser(),
              builder: (context, user) {

                if (user.hasData) {
                  return StreamBuilder<LanguageModel>(
                      stream: FirebaseManger.shard.getLanguageByUid(uid: user.data.uidLanguage),
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return _item(context, item: snapshot.data, level: user.data.currentLevel, isActive: true);
                            },
                          );
                        } else {
                          return Center(child: loader(context));
                        }
                      }
                  );
                } else {
                  return Center(child: loader(context));
                }

              }
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/SelectLanguage"),
                  child: Container(
                    width: MediaQuery.of(context).size.width * (48 / 375),
                    height: MediaQuery.of(context).size.width * (48 / 375),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 26,),
                  ),
                ),
                SizedBox(width: 10,),
                Text("Add a new language", style: TextStyle(fontSize: 16, color: "#242833".toHexa()),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(context, { @required LanguageModel item, @required Level level, bool isActive = false }) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: isActive ? "#EDF1F2".toHexa() : Colors.transparent,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * (52 / 375),
            height: MediaQuery.of(context).size.width * (52 / 375),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(item.image),
          ),
          SizedBox(width: 18,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("English", style: TextStyle(color: "#242833".toHexa(), fontSize: 16),),
              SizedBox(height: 4,),
              Text("Level ${level.index + 1}", style: TextStyle(color: "#7E8494".toHexa(), fontSize: 14),),
            ],
          ),
        ],
      ),
    );
  }

}
