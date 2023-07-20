import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/src/screens/login_screen.dart';
import 'package:firebase1/src/services/forgotpass_service.dart';
import 'package:firebase1/src/services/signin_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/ani_constants.dart';
import '../constants/image_constants.dart';
import '../constants/text_constants.dart';
// import "dart:developer";

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  // TextEditingController userPhnoController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
          centerTitle: true,
          // actions: [
          //   Icon(Icons.more_vert),
          // ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(child: Lottie.asset(aniName3)),
                  ),
                  Form(
                    key: formKey,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: true,
                          controller: userEmailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: signinText3,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autofocus: true,
                          controller: otpController,
                          decoration: const InputDecoration(
                            labelText: "OTP",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                                onPressed: isLoading ? null : () {
                                  var userEmail = userEmailController.text.trim();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  generateOTP(context, userEmail);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text("Generate OTP"),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                                onPressed: () {
                                  var userEmail = userEmailController.text.trim();
                                  var otp = otpController.text.trim();
                                  verifyOTP(context, userEmail, otp);
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text("Verify OTP"),
                              ),
                      ),
                    ]),
                  )
                ])));
  }
}
