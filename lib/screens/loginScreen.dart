import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/constants/routes.dart';
import 'package:zoom_clone/constants/styles.dart';
import 'package:zoom_clone/constants/widgets.dart';
import 'package:zoom_clone/controller/authenication.dart';
import 'package:zoom_clone/screens/setProfileScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = true;
  String _email, _pass;
  final _formKey = GlobalKey<FormState>();
  OverlayEntry progress = progressOverlay;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    validator: ValidationBuilder().email().required().build(),
                    onSaved: (value) {
                      _email = value;
                    },
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
                    validator:
                        ValidationBuilder().minLength(8).required().build(),
                    onSaved: (value) {
                      _pass = value;
                    },
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
                  children: [
                    InkWell(
                      child: colorButton(buttonText: "Sign In"),
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          Overlay.of(context).insert(progress);
                          _formKey.currentState.save();

                          Authentication.login(
                                  context: context,
                                  email: _email,
                                  password: _pass)
                              .then((user) async {
                            progress.remove();
                            if (user != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'userId', user.uid.toString());

                              //Navigate to home
                              Navigator.of(context)
                                  .pushReplacementNamed(HOME_SCREEN);
                            }
                          });
                        }
                      },
                    )
                  ],
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
                          Overlay.of(context).insert(progress);
                          Authentication.signInWithGoogle(context: context)
                              .then((user) async {
                            if (user != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString(
                                  'userId', user.uid.toString());

                              if (user.metadata.creationTime
                                      .difference(user.metadata.lastSignInTime)
                                      .abs() <
                                  Duration(seconds: 1)) {
                                progress.remove();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => setProfileScreen(
                                      user: user,
                                    ),
                                  ),
                                );
                              } else {
                                progress.remove();
                                //Navigate to home
                                Navigator.of(context)
                                    .pushReplacementNamed(HOME_SCREEN);
                              }
                            } else {
                              progress.remove();
                            }
                          });
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
                          Navigator.of(context).pushNamed(REGISTER_SCREEN);
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
