import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/widgets/btn-back.dart';
import 'package:lengo/widgets/btn-main.dart';

class ForgotPassword extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();

  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * (50 / 812),
              ),
              Row(
                children: [
                  BtnBack(),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (76 / 812),
              ),
              Text(
                "Forget password",
                style: TextStyle(
                    color: "#333333".toHexa(),
                    fontSize: 29,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Enter your email \nto reset your password ",
                textAlign: TextAlign.center,
                style: TextStyle(color: "#777777".toHexa(), fontSize: 14),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (66 / 812),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  onSaved: (value) => email = value.trim(),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (80 / 812),
              ),
              BtnMain(title: "Send", onTap: () => _btnForgotPassword(context)),
            ],
          ),
        ),
      ),
    );
  }

  _btnForgotPassword(context) async {
    _formKey.currentState.save();

    if (email == "") {
      _scaffoldKey.showTosta(message: "Please enter the email", isError: true);
      return;
    }

    bool isSuccess = await FirebaseManger.shard
        .forgotPassword(scaffoldKey: _scaffoldKey, email: email);

    if (isSuccess) {
      Navigator.of(context)
          .pushReplacementNamed("/CheckEmail", arguments: email);
    } else {
      _scaffoldKey.showTosta(
          message: "Something went wrong, please try again later",
          isError: true);
    }
  }
}
