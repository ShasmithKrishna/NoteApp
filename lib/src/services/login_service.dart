import 'package:firebase1/src/screens/note_home_screen.dart';
import 'package:firebase1/src/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/ani_constants.dart';

void logIn(context, userEmail, userPassword) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      if (userCredential.user != null) {
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Lottie.asset(aniName2),
            backgroundColor: Colors.green,
          ),
        );
        Get.to(() => NoteHomeScreen());
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
          backgroundColor: Colors.red,
        ),
      );
        Get.to(() => new LoginPage());
    }
}
