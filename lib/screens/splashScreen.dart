import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_clone/constants/colors.dart';
import 'package:zoom_clone/constants/routes.dart';
import 'package:zoom_clone/screens/homeScreen.dart';
import 'package:zoom_clone/screens/onBoardScreen.dart';
import 'package:zoom_clone/utils/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String startScreen;
  loadScreen() async {
    String loggedIn = await getUid();
    startScreen = loggedIn == null ? INTRO_SCREEN : HOME_SCREEN;
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(startScreen);
  }

  @override
  void initState() {
    super.initState();
    loadScreen();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: appPurple,
          ),
          Center(
            child: SvgPicture.asset("assets/images/logo.svg"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
