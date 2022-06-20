import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:login_ui/views/login/login_success.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, password) async {
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      var response = await post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login successfully');

        return Get.to(() => const LoginSuccess());
      } else {
        print('failed');
        return Get.snackbar(
          'Error',
          'Please fill all Fields',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          icon: Icon(Icons.dangerous),
          backgroundColor: Color.fromARGB(255, 242, 74, 63),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

// Text Fields
  Column _textFields(
    textInputType,
    String? Function(String?) validator,
    String name,
    String hintText,
    controller,
    bool obscureText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.outfit(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: textInputType,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.only(
              left: 12,
            ),
            hintStyle: GoogleFonts.outfit(
              fontSize: 18,
              color: const Color.fromRGBO(202, 202, 202, 1),
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(),
          ),
        ),
      ],
    );
  }

// Button Border
  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color.fromRGBO(240, 148, 51, 1),
        width: 1.0,
      ),
    );
  }

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
                      color: Color.fromARGB(255, 245, 187, 126),
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
                    _textFields(
                      TextInputType.emailAddress,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return "Error";
                        }
                      },
                      'Email',
                      'E-Mail',
                      emailController,
                      false,
                    ),
                    const SizedBox(height: 10),
                    _textFields(
                      TextInputType.text,
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Length is too Short';
                        }
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
                        login(
                          emailController.text.toString(),
                          passwordController.text.toString(),
                        );
                        print('Login Button Clicked');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromRGBO(240, 148, 51, 1),
                        ),
                        child: Text('LOGIN'),
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
                      onTap: () {
                        Get.snackbar(
                            snackPosition: SnackPosition.BOTTOM,
                            'Facebook Button CLickd',
                            '');
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
