import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:lengo/screen/admin_screen/helper/binding.dart';
import 'package:lengo/screen/auth.dart';
import 'package:lengo/screen/check-email.dart';
import 'package:lengo/screen/forgot_password.dart';
import 'package:lengo/screen/get_start.dart';
import 'package:lengo/screen/level/finished-level.dart';
import 'package:lengo/screen/level/level.dart';
import 'package:lengo/screen/select_language_page.dart';
import 'package:lengo/screen/splash.dart';
import 'package:lengo/screen/tabbar/tabbar.dart';
import 'package:lengo/utils/extensions.dart';
import 'screen/signup/signup_complete_data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return GetMaterialApp(
      initialBinding: Binding(),
      title: "lengo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: "#0A7E89".toHexa(),
        accentColor: "#D46795".toHexa(),
        backgroundColor: Colors.white,
        fontFamily: 'NeoSansArabic',
        cursorColor: Theme.of(context).primaryColor,
          // textSelectionTheme: TextSelectionThemeData(
          //   cursorColor: Theme.of(context).primaryColor
          // )

      ),

      initialRoute: "/Splash",
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/Splash':
            return MaterialPageRoute(builder: (_) => Splash());
          case '/GetStart':
            return MaterialPageRoute(builder: (_) => GetStart());
          case '/Auth':
            return MaterialPageRoute(builder: (_) => Auth(pageType: arguments,));
          case '/SignupCompleteData':
            return MaterialPageRoute(builder: (_) => SignupCompleteData());
          case '/ForgotPassword':
            return MaterialPageRoute(builder: (_) => ForgotPassword());
          case '/CheckEmail':
            return MaterialPageRoute(builder: (_) => CheckEmail(email: arguments,));
          case '/TabBar':
            return MaterialPageRoute(builder: (_) => TabBarPage());
          case '/SelectLanguage':
            return MaterialPageRoute(builder: (_) => SelectLanguagePage());
          case '/Level':
            return MaterialPageRoute(builder: (_) => Level(categoryModel: arguments,));
          case '/FinishedLevel':
            return MaterialPageRoute(builder: (_) => FinishedLevel(categoryModel: arguments,));
          default:
            return null;
        }
      },
    );
  }
}


// Add Qusetion In Categorey , Delete Or Update .