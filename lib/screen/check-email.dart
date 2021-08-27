import 'package:flutter/material.dart';
import 'package:lengo/enums/auth_page_type.dart';
import 'package:lengo/widgets/btn-back.dart';
import 'package:lengo/widgets/btn-main.dart';
import 'package:lengo/utils/extensions.dart';

class CheckEmail extends StatelessWidget {

  final String email;

  const CheckEmail({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: MediaQuery.of(context).size.height * (76 / 812),),
            Text("Check your email !", style: TextStyle(color: "#333333".toHexa(), fontSize: 29, fontWeight: FontWeight.w500),),
            SizedBox(height: 32,),
            Text("The recovery link was sent to the email\n$email\nPlease follow the recovery link.", textAlign: TextAlign.center, style: TextStyle(color: "#777777".toHexa(), fontSize: 14, height: 2.5),),
            SizedBox(height: MediaQuery.of(context).size.height * (150 / 812),),
            BtnMain(title: "Go to login page", onTap: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}
