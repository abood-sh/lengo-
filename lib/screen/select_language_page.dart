import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/utils/user_profile.dart';
import 'package:lengo/widgets/btn-back.dart';
import 'package:lengo/widgets/btn-main.dart';
import 'package:lengo/utils/extensions.dart';
import 'signup/select_language.dart';

class SelectLanguagePage extends StatefulWidget {
  @override
  _SelectLanguagePageState createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {

  LanguageModel selectedItem;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * (50 / 812),),
            Row(
              children: [
                BtnBack(),
              ],
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Text("Select a language to learn :", style: TextStyle(color: "#333333".toHexa(), fontSize: 20, fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * (40 / 812),),
            Expanded(child: SelectLanguage(activeItem: selectedItem, handlerOnTap: (language) {
              setState(() {
                selectedItem = language;
              });
            },)),
            SizedBox(height: MediaQuery.of(context).size.height * (40 / 812),),
            BtnMain(title: "Confirm", onTap: () async {

              if (selectedItem == null) {
                _scaffoldKey.showTosta(message: "Please choose a language", isError: true);
                return;
              }

              UserModel user = await UserProfile.shared.getUser();

              if (user.uidLanguage == selectedItem.uid) {
                _scaffoldKey.showTosta(message: "This language already exists", isError: true);
                return;
              }

            }),
          ],
        ),
      ),
    );
  }
}
