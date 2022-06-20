// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'functions.dart';
import 'widgets/text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoggedIn = false;
  Map _userDetails = {};

  bool isValidEmail(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 0),
              Stack(
                children: [
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: [
                          00.1,
                          0.9,
                        ],
                        colors: [
                          Color.fromRGBO(240, 148, 51, 1),
                          Color.fromARGB(255, 255, 232, 207),
                        ],
                      ),
                      // image: DecorationImage(
                      //   image: AssetImage('assets/images/login/1.png'),
                      // ),
                      color: const Color.fromARGB(255, 245, 187, 126),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                          Get.width,
                          Get.width * 0.4,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    child: Image.asset(
                      'assets/images/login/2.png',
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome!',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.abrilFatface(
                          fontSize: 42,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'For login to your account fill the following details to continue',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        color: const Color.fromRGBO(138, 138, 138, 1),
                      ),
                    ),
                    const SizedBox(height: 25),
                    textFields(
                      TextInputType.emailAddress,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return "Error";
                        }
                        return null;
                      },
                      'Email',
                      'E-Mail',
                      emailController,
                      false,
                    ),
                    const SizedBox(height: 10),
                    textFields(
                      TextInputType.text,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Length is too Short';
                        }
                        return null;
                      },
                      'Password',
                      "Password",
                      passwordController,
                      true,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password? ',
                        textAlign: TextAlign.end,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (emailController.text.trim().isEmpty) {
                          //toast
                          //email is empty
                          print('E-Mail Is Empty');
                          snackBar('E-Mail is Empty');
                        } else if (!isValidEmail(emailController.text.trim())) {
                          //show msg for invalid email
                          print('Please Enter Valid Email');
                          snackBar('Please Enter a Valid E-Mail');
                        } else if (passwordController.text.trim().isEmpty) {
                          //show msg for empty pasword
                          print('Please Enter Password');
                          snackBar('Please Enter Password');
                        } else if (passwordController.text.trim().length < 6) {
                          // show msg
                          print('Password Length Should be greater than 6');
                          snackBar('Password Length Should be greater than 6');
                        } else {
                          login(
                            emailController.text.toString(),
                            passwordController.text.toString(),
                          );
                          print('Login Button Clicked');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromRGBO(240, 148, 51, 1),
                        ),
                        child: const Text('LOGIN'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '----Or Login With----',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        color: const Color.fromRGBO(138, 138, 138, 1),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await FacebookAuth.instance.login(
                          permissions: [
                            "email",
                            "public_profile",
                          ],
                        ).then((value) {
                          FacebookAuth.instance.getUserData().then((userData) {
                            setState(() {
                              _isLoggedIn = true;
                              _userDetails = userData;
                            });
                          });
                        });

                        print('Facebook Button Clicked');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 7,
                            ),
                            const Icon(
                              Icons.facebook,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Facebook',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.dangerous_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Color.fromRGBO(138, 138, 138, 1),
                        ),
                        children: [
                          TextSpan(
                              text: "Signup",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Signed Up Button Clicked');
                                },
                              style: const TextStyle(
                                color: Color.fromRGBO(240, 148, 51, 1),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
