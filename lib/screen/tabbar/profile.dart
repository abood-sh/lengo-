import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lengo/enums/gender.dart';
import 'package:lengo/model/activity-history-model.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/screen/admin_screen/admin_screen.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/utils/user_profile.dart';
import 'package:lengo/widgets/alert.dart';
import 'package:lengo/widgets/loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {

  TabController _tabController;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return auth.currentUser.email == "admin@email.com" ? AdminScreen() : Scaffold(
      appBar: AppBar(
        backgroundColor: "#F5FEFF".toHexa(),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {
            showAlertDialog(context, title: "Logout", message: "Are you sure to logout?", titleBtnOne: "Logout", titleBtnTwo: "Cancel", actionBtnOne: () {
              FirebaseManger.shard.logout(context);
            }, actionBtnTwo: () {
              Navigator.of(context).pop();
            });
          }, icon: Icon(Icons.logout, color: Theme.of(context).accentColor,), tooltip: "logout",)
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<UserModel>(
            future: FirebaseManger.shard.getUserByUid(uid: FirebaseManger.shard.auth.currentUser.uid),
            builder: (context, snapshot) {

              if (snapshot.hasData) {

                UserModel user = snapshot.data;

                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * (268 / 812),
                  decoration: BoxDecoration(
                    color: "#F5FEFF".toHexa(),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 45,
                        child: Center(child: SvgPicture.asset(user.gender == Gender.MALE ? Assets.shared.icMale : Assets.shared.icFemale, fit: BoxFit.cover, height: MediaQuery.of(context).size.height * (80 / 812),)),
                      ),
                      SizedBox(height: 16,),
                      Text(user.userName, style: TextStyle(fontSize: 20, color: "#3C3E40".toHexa()),),
                      SizedBox(height: 14,),
                      Container(
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * (150 / 375),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(child: Text(user.score.toString(), style: TextStyle(fontSize: 13),)),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: loader(context),);
              }

            }
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: "#BEBEBE".toHexa(),
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Text("Stats".toUpperCase(), style: TextStyle(fontSize: 16),),
              ),
              Tab(
                child: Text("Achievements".toUpperCase(), style: TextStyle(fontSize: 16),),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _stats(context),
                _achievements(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  List<SalesData> chartData = [
    SalesData("Mon", 0),
    SalesData("Tue", 0),
    SalesData("Wed", 0),
    SalesData("Thu", 0),
    SalesData("Fri", 0),
    SalesData("Sat", 0),
    SalesData("Sun", 0),
  ];

  _updateNumberInChart({ @required DateTime date, @required double number }) {
    for (var item in chartData) {
      if (item.day == weekDays[date.weekday - 1]) {
        item.number = number;
        break;
      }
    }
  }
  
  Widget _stats(context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: StreamBuilder<List<ActivityHistoryModel>>(
        stream: FirebaseManger.shard.getActivityHistory(),
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            for (var item in snapshot.data) {
              _updateNumberInChart(date: item.date, number: item.score.toDouble());
            }

            return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  // Renders column chart
                  ColumnSeries<SalesData, String>(
                      dataSource: chartData,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      width: 0.2,
                      color: Theme.of(context).primaryColor,
                      xValueMapper: (SalesData sales, _) => sales.day,
                      yValueMapper: (SalesData sales, _) => sales.number
                  )
                ]
            );
          } else {
            return Center(child: loader(context),);
          }

        }
      ),
    );
  }

  Widget _achievements(context) {
    return FutureBuilder<UserModel>(
      future: UserProfile.shared.getUser(),
      builder: (context, snapshot) {

        if (snapshot.hasData) {

          List<String> uidLanguages = snapshot.data.uidLanguage.split(", ");

          return ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: uidLanguages.length,
            itemBuilder: (context, index) {
              return _item(uidLanguage: uidLanguages[index]);
            },
          );
        } else {
          return SizedBox();
        }

      }
    );
  }

  Widget _item({ @required uidLanguage }) {
    return StreamBuilder<LanguageModel>(
      stream: FirebaseManger.shard.getLanguageByUid(uid: uidLanguage),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(snapshot.data.image),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: FutureBuilder<double>(
                    future: FirebaseManger.shard.getUserCompletionPercentage(uidLanguage: snapshot.data.uid),
                    builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return SizedBox();
                        }

                        double rate = snapshot.data;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$rate% fluent in total", style: TextStyle(fontSize: 16, color: "#242833".toHexa()),),
                          SizedBox(height: 16,),
                          Container(
                            width: double.infinity,
                            height: 4,
                            decoration: BoxDecoration(
                              color: "#DFE8E9".toHexa(),
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            child: LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  return Row(
                                    children: [
                                      Container(
                                        width: constraints.maxWidth * (rate / 100),
                                        height: constraints.maxHeight,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(Radius.circular(2)),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      }
    );
  }

}

class SalesData {
  SalesData(this.day, this.number);
  String day;
  double number;
}