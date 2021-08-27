import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/widgets/btn-main.dart';

import '../enums/auth_page_type.dart';

class GetStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.shared.icStart,
                    width: MediaQuery.of(context).size.width * (120 / 375),
                    height: MediaQuery.of(context).size.height * (120 / 375),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (80 / 812),
            ),
            BtnMain(title: "Login With Email", onTap: () => Navigator.of(context).pushReplacementNamed("/Auth", arguments: AuthPageType.SIGN_IN)),
            SizedBox(height: 35,),
            Text("Don’t Have An Account?", style: TextStyle(color: "#555555".toHexa(), fontSize: 18, fontWeight: FontWeight.w400),),
            FlatButton(onPressed: () => Navigator.of(context).pushReplacementNamed("/Auth", arguments: AuthPageType.SIGN_UP), child: Text("Sign up", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),))
          ],
        ),
      ),
    );
  }
}
