import 'package:flutter/material.dart';
import 'package:onboarding_concept/constants.dart';
import 'package:onboarding_concept/screens/login/widgets/blue_top_clipper.dart';
import 'package:onboarding_concept/screens/login/widgets/grey_top_clipper.dart';
import 'package:onboarding_concept/screens/login/widgets/header.dart';
import 'package:onboarding_concept/screens/login/widgets/login_form.dart';
import 'package:onboarding_concept/screens/login/widgets/white_top_clipper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var boxHeight = screenHeight / 6;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WhiteTopClipper(),
            child: Container(
              color: kGrey,
            ),
          ),
          ClipPath(
            clipper: GreyTopClipper(),
            child: Container(color: kBlue),
          ),
          ClipPath(
            clipper: BlueTopClipper(),
            child: Container(
              color: kWhite,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kPaddingL),
              child: Column(
                children: <Widget>[
                  Header(),
                  SizedBox(height: boxHeight),
                  LoginForm(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
