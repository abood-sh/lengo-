import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lengo/model/user-model.dart';
import 'package:lengo/screen/admin_screen/admin_screen.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/user_profile.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      UserModel user = await UserProfile.shared.getUser();
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("/GetStart");
        if (auth.currentUser.email == "admin@email.com") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> AdminScreen()));
        }
      } else {
        Navigator.of(context).pushReplacementNamed("/TabBar");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 35),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  Assets.shared.icLogo,
                  width: MediaQuery.of(context).size.width * (80 / 375),
                  height: MediaQuery.of(context).size.height * (80 / 375),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Lengo",
                style: TextStyle(
                    color: "#555555".toHexa(),
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
