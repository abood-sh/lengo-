import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lengo/utils/assets.dart';
import 'package:lengo/utils/extensions.dart';
import 'package:lengo/utils/firebase-manager.dart';
import 'package:lengo/widgets/btn-main.dart';
import 'package:lengo/enums/auth_page_type.dart';

class Auth extends StatefulWidget {

  final AuthPageType pageType;

  const Auth({Key key, this.pageType}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();

  String userName;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * (100 / 812),),
              SvgPicture.asset(Assets.shared.icNote, height: MediaQuery.of(context).size.height * (50 / 812),),
              SizedBox(height: MediaQuery.of(context).size.height * (50 / 812),),
              Text(widget.pageType == AuthPageType.SIGN_UP ? "Create an account" : "Welcome Back!", style: TextStyle(color: "#333333".toHexa(), fontSize: 29,),),
              SizedBox(height: MediaQuery.of(context).size.height * (50 / 812),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Visibility(
                        visible: widget.pageType == AuthPageType.SIGN_UP,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onSaved: (value) => this.userName = value.trim(),
                              decoration: InputDecoration(
                                  labelText: "Username"
                              ),
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => this.email = value.trim(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email"
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        onSaved: (value) => this.password = value.trim(),
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "Password"
                        ),
                      ),
                      SizedBox(height: 20,),
                      Visibility(
                        visible: widget.pageType == AuthPageType.SIGN_IN,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(onTap: () => Navigator.of(context).pushNamed("/ForgotPassword"), child: Text("Forgot Password?", style: TextStyle(color: "#555555".toHexa()),)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * (50 / 812),),
              BtnMain(title: widget.pageType == AuthPageType.SIGN_UP ? "Sign up" : "Login".toUpperCase(), onTap: () => _btnMain(context)),
              SizedBox(height: 20,),
              Text(widget.pageType == AuthPageType.SIGN_UP ? "Do you hava account?" : "Don’t Have An Account?", style: TextStyle(color: "#555555".toHexa()),),
              FlatButton(onPressed: () {
                switch (widget.pageType) {
                  case AuthPageType.SIGN_UP:
                    Navigator.of(context).pushReplacementNamed("/Auth", arguments: AuthPageType.SIGN_IN);
                    break;
                  case AuthPageType.SIGN_IN:
                    Navigator.of(context).pushReplacementNamed("/Auth", arguments: AuthPageType.SIGN_UP);
                    break;
                }
              }, child: Text(widget.pageType == AuthPageType.SIGN_UP ? "Login" : "Sign up", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),)),
            ],
          ),
        ),
      ),
    );
  }

  bool _validation() {
    switch (widget.pageType) {
      case AuthPageType.SIGN_UP:
        return !(userName == "" || email == "" || password == "");
      case AuthPageType.SIGN_IN:
        return !(email == "" || password == "");
      default: return false;
    }
  }

  _btnMain(context) {

    _formKey.currentState.save();

    if (!_validation()) {
      _scaffoldKey.showTosta(message: "Please enter all fields", isError: true);
      return;
    }

    if (!password.isValidPassword()) {
      _scaffoldKey.showTosta(message: "Password must be at least 6 characters long ant at most 15 characters long", isError: true);
      return;
    }

    switch (widget.pageType) {
      case AuthPageType.SIGN_UP:
        FirebaseManger.shard.createAccountUser(scaffoldKey: _scaffoldKey, userName: userName, email: email, password: password);
        break;
      case AuthPageType.SIGN_IN:
        FirebaseManger.shard.login(scaffoldKey: _scaffoldKey, email: email, password: password);
        break;
    }
  }
}
