import 'package:flutter/material.dart';
import 'package:lengo/enums/gender.dart';
import 'package:lengo/enums/level.dart';
import 'package:lengo/enums/signup_page_type.dart';
import 'package:lengo/model/language-model.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/widgets/btn-main.dart';
import 'select_gender.dart';
import 'select_language.dart';
import 'select_level.dart';

class SignupCompleteData extends StatefulWidget {
  @override
  _SignupCompleteDataState createState() => _SignupCompleteDataState();
}

class _SignupCompleteDataState extends State<SignupCompleteData> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  SignupPageType pageType;
  LanguageModel selectedLanguage;
  Level selectedLevel;
  Gender selectedGender;

  String title;
  double progressValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageType = SignupPageType.SELECT_LANGUAGE;
    _setupPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * (60 / 812),),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: "#DFE8E9".toHexa(),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    children: [
                      Container(
                        width: (constraints.maxWidth * progressValue),
                        height: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ],
                  );
                },
          ),
            ),
            SizedBox(height: 35,),
            Row(
              children: [
                Flexible(child: Text(title, style: TextStyle(color: "#333333".toHexa(), fontSize: 22, fontWeight: FontWeight.w500, height: 2),)),
              ],
            ),
            Expanded(
              child: _renderItem()
            ),
            SizedBox(height: 35,),
            BtnMain(title: pageType == SignupPageType.SELECT_GENDER ? "Ok" : "Next", onTap: _btnNext),
          ],
        ),
      ),
    );
  }

  Widget _renderItem() {
    switch (pageType) {
      case SignupPageType.SELECT_LANGUAGE:
        return SelectLanguage(activeItem: selectedLanguage, handlerOnTap: (language) {
          setState(() {
            selectedLanguage = language;
          });
        },);
      case SignupPageType.SELECT_LEVEL:
        return SelectLevel(language: selectedLanguage, activeItem: selectedLevel, handlerOnTap: (index) {
          setState(() {
            selectedLevel = index;
          });
        },);
      case SignupPageType.SELECT_GENDER:
        return SelectGender(activeItem: selectedGender, handlerOnTap: (index) {
          setState(() {
            selectedGender = index;
          });
        },);
      default: return SizedBox();
    }
  }

  _setupPage() {
    switch (pageType) {
      case SignupPageType.SELECT_LANGUAGE:
        title = "Select the language you want to learn:";
        progressValue = (100 / 3) / 100;
        break;
      case SignupPageType.SELECT_LEVEL:
        title = "Select your current level";
        progressValue = (100 / 2) / 100;
        break;
      case SignupPageType.SELECT_GENDER:
        title = "Select your Gender?";
        progressValue = 1;
        break;
    }
  }

  bool _validation() {
    switch (pageType) {
      case SignupPageType.SELECT_LANGUAGE:
        if (selectedLanguage == null) {
          _scaffoldKey.showTosta(message: "Please select the language", isError: true);
          return false;
        }
        return true;
      case SignupPageType.SELECT_LEVEL:
        if (selectedLevel == null) {
          _scaffoldKey.showTosta(message: "Please select a level", isError: true);
          return false;
        }
        return true;
      case SignupPageType.SELECT_GENDER:
        if (selectedGender == null) {
          _scaffoldKey.showTosta(message: "Please choose a gender ", isError: true);
          return false;
        }
        return true;
      default: return false;
    }
  }

  _btnNext() {
    if (!_validation()) {
      return;
    }

    if (pageType.index < 2) {
      setState(() {
        pageType = SignupPageType.values[pageType.index + 1];
        _setupPage();
      });
      return;
    }

    FirebaseManger.shard.completeUserData(scaffoldKey: _scaffoldKey, uidLanguage: selectedLanguage.uid, currentLevel: selectedLevel, gender: selectedGender);
  }

}
