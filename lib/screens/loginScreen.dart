import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_clone/constants/colors.dart';
import 'package:zoom_clone/constants/styles.dart';
import 'package:zoom_clone/constants/widgets.dart';
import 'package:zoom_clone/controller/authenication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authDecoratedBox(
                  childWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 20),
                        child: Text(
                          "Let's sign you in.",
                          style: labelStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 20),
                        child: Text(
                          "Welcome back.",
                          style: labelStyle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, bottom: 50),
                        child: Text(
                          "You have been missed!",
                          style: labelStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                  decoration: inputBoxDecoration,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email Address",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  decoration: inputBoxDecoration,
                  child: TextFormField(
                    obscureText: showPass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.remove_red_eye),
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                      ),
                      labelText: "Password",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot Password?",
                        style: labelStyle3,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [colorButton(buttonText: "Sign In")],
                ),
                dividerOrWidget,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        child: SvgPicture.asset(
                          "assets/images/google.svg",
                          height: 50,
                          width: 50,
                        ),
                        onTap: () async {
                          User user = await Authentication.signInWithGoogle(
                              context: context);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      InkWell(
                        child: Text(
                          "Sign Up",
                          style: labelStyle3,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
