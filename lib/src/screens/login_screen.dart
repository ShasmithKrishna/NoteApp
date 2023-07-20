import 'package:firebase1/src/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../constants/image_constants.dart';
import '../constants/text_constants.dart';
import '../services/login_service.dart';
import 'forgotpass_screen.dart';
import 'note_home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  bool _isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(loginText1),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage(logoName)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded),
                    fillColor: Colors.lightBlueAccent,
                    labelText: loginText3,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: userPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_rounded),
                    suffixIcon: Icon(Icons.visibility),
                    fillColor: Colors.lightBlueAccent,
                    labelText: loginText4,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ),
              ),
              // _isLogin? const CircularProgressIndicator() :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        var userEmail = userEmailController.text.trim();
                        var userPassword = userPasswordController.text.trim();
                        setState(() {
                          _isLogin = true;
                        });
                        logIn(context, userEmail, userPassword);
                        // setState(() {
                        //   _isLogin = false;
                        // });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(loginText2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => {
                        Get.to(() => SignUpPage())
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: const Text(loginText5),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => {
                  Get.to(() => ForgotPassPage())
                },
                child: Container(alignment: Alignment.center,
                child:  const Card(
                  borderOnForeground: false,
                  semanticContainer: false,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Forgot Password?", style: TextStyle(
                      fontSize: 15,
                    ),),
                  ))
                ),
              )
            ]),
      ),
    );
  }
}
