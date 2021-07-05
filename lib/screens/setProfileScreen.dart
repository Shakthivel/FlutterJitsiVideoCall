import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:zoom_clone/constants/colors.dart';
import 'package:zoom_clone/constants/styles.dart';
import 'package:zoom_clone/constants/widgets.dart';
import 'package:zoom_clone/controller/database.dart';
import 'package:zoom_clone/utils/image.dart';
import 'package:zoom_clone/utils/shared_prefs.dart';

class setProfileScreen extends StatefulWidget {
  final User user;
  const setProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _setProfileScreenState createState() => _setProfileScreenState();
}

class _setProfileScreenState extends State<setProfileScreen> {
  User user;
  File selectedImage;
  TextEditingController usernameController;
  final _formKey = GlobalKey<FormState>();
  var _username;
  @override
  void initState() {
    super.initState();
    user = widget.user;
    _username =
        user.displayName == null ? user.email.split("@")[0] : user.displayName;
    usernameController = new TextEditingController(text: "$_username");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appPurple,
          title: Text("Set Profile"),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                        child: InkWell(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: selectedImage != null
                                    ? Image.file(
                                        selectedImage,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : user.photoURL != null
                                        ? Image.network(
                                            user.photoURL,
                                            height: 150,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.person_sharp,
                                            color: appPurple,
                                            size: 150,
                                          ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                child: Icon(
                                  Icons.add_circle,
                                  color: appPurple,
                                  size: 40,
                                ),
                              ),
                            ],
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
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: inputBoxDecoration,
                        child: TextFormField(
                          validator: ValidationBuilder().minLength(6).build(),
                          onSaved: (value) {
                            _username = value;
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Username",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: InkWell(
                  child: colorButton(buttonText: "Continue"),
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if ((user.photoURL == null) && (selectedImage == null)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Select a photo"),
                          ),
                        );
                      } else {
                        var url = user.photoURL;
                        if (selectedImage != null) {
                          await getUid().then((value) async {
                            print(value);
                            var storage = FirebaseStorage.instance;
                            TaskSnapshot snapshot = await storage
                                .ref()
                                .child("images/$value")
                                .putFile(selectedImage);
                            if (snapshot.state == TaskState.success) {
                              url = await snapshot.ref.getDownloadURL();
                            } else {
                              print(
                                  'Error from image repo ${snapshot.state.toString()}');
                              throw ('This file is not an image');
                            }
                          });
                        }
                        print(url);
                        Database.addItem(
                            email: user.email,
                            username: _username,
                            imageUrl: url);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
