import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/ani_constants.dart';
import '../screens/login_screen.dart';

void signIn(context, formKey, userName, userPhno, userEmail,
    userPassword, usercPassword) async {
  // if (formKey.currentState!.validate()) {
    // if (userPassword == usercPassword) {
      // log("Passwords do not match");
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmail, password: userPassword)
          .then((value) => {
                log("User signed up successfully"),
                FirebaseFirestore.instance
                    .collection("users")
                    .doc()
                    .set({
                      "name": userName,
                      "phno": userPhno,
                      "email": userEmail,
                    })
                    .then((value) => {
                          log("Data Added"),
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Lottie.asset(
                                  aniName2))),
                          Get.to(() => LoginPage())
                        })
                    .catchError((error) {
                      log("Error adding data: $error");
                      return error;
                    })
              })
          .catchError((error) {
        log("Error creating user: $error");
        return error;
      });
    // }
  // }
}
