import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/controller/database.dart';

class Authentication {
  static Future<User> register({
    email,
    password,
    // imgUrl,
    context,
  }) async {
    User user;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((result) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', result.user.uid.toString());
      user = result.user;
    }).then((result) {
      //add user details to firestore
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.message.toString(),
          ),
        ),
      );
    });
    return user;
  }

  static Future<User> signInWithGoogle(
      {BuildContext context, bool register}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', user.uid.toString());

          if (register) {
            Database.addItem(
                email: user.email,
                username: user.displayName,
                imageUrl: user.photoURL);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message.toString())));
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message.toString())));
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message.toString())));
        }
      }
    }

    return user;
  }
}
