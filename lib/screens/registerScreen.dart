import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:zoom_clone/constants/styles.dart';
import 'package:zoom_clone/constants/widgets.dart';
import 'package:zoom_clone/controller/authenication.dart';
import 'package:zoom_clone/utils/image.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showPass = true;
  bool showConfirmPass = true;
  File selectedImage;
  String _email, _pass, _cpass;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                authDecoratedBox(
                  childWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "Sign Up.",
                          style: labelStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 20, bottom: 50),
                        child: Text(
                          "Create an account!",
                          style: labelStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: InkWell(
                    child: selectedImage == null
                        ? SvgPicture.asset(
                            "assets/images/add_dp.svg",
                            height: 75,
                            width: 75,
                          )
                        : Image.file(
                            selectedImage,
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                          ),
                    onTap: () async {
                      await selectImage().then((value) {
                        setState(() {
                          selectedImage = value;
                        });
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  decoration: inputBoxDecoration,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email Address",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                    validator: ValidationBuilder().email().required().build(),
                    onSaved: (value) {
                      _email = value;
                    },
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
                      validator:
                          ValidationBuilder().minLength(8).required().build(),
                      onSaved: (value) {
                        _pass = value;
                      }),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  decoration: inputBoxDecoration,
                  child: TextFormField(
                    obscureText: showConfirmPass,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        child: Icon(Icons.remove_red_eye),
                        onTap: () {
                          setState(() {
                            showConfirmPass = !showConfirmPass;
                          });
                        },
                      ),
                      labelText: "Confirm Password",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                    validator:
                        ValidationBuilder().minLength(8).required().build(),
                    onSaved: (value) {
                      _cpass = value;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: colorButton(buttonText: "Sign Up"),
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (_pass == _cpass) {
                            Authentication.register(
                                    context: context,
                                    email: _email,
                                    password: _pass)
                                .then((user) {
                              if (user != null) {
                                //Navigate
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password does not match"),
                              ),
                            );
                          }
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
                          Authentication.signInWithGoogle(context: context)
                              .then((user) {
                            if (user != null) {
                              //Navigate
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
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      InkWell(
                        child: Text(
                          "Sign In",
                          style: labelStyle3,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
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
