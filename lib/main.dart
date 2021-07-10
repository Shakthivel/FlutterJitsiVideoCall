import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_clone/constants/routes.dart';
import 'package:zoom_clone/screens/loginScreen.dart';
import 'package:zoom_clone/screens/registerScreen.dart';
import 'package:zoom_clone/screens/setProfileScreen.dart';
import 'package:zoom_clone/screens/splashScreen.dart';

import 'constants/colors.dart';
import 'screens/onBoardScreen.dart';
import 'screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        SPLASH_SCREEN: (ctx) => SplashScreen(),
        INTRO_SCREEN: (ctx) => OnBoardScreen(),
        HOME_SCREEN: (ctx) => HomeScreen(),
        SET_PROFILE_SCREEN: (ctx) => setProfileScreen(),
        LOGIN_SCREEN: (ctx) => LoginScreen(),
        REGISTER_SCREEN: (ctx) => RegisterScreen(),
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: appPurple,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/images/logo.svg",
              height: 175,
              width: 175,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
