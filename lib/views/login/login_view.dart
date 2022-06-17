import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController? _emailController;
  late TextEditingController? _passwordController;
  Column _textFields(
    String name,
    String hintText,
    TextEditingController? controller,
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
        TextField(
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
                    const SizedBox(height: 35),
                    _textFields(
                      'Email',
                      'E-Mail',
                      _emailController,
                      false,
                    ),
                    const SizedBox(height: 29),
                    _textFields(
                      'Password',
                      "Password",
                      _passwordController,
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
                    const SizedBox(height: 35),
                    MaterialButton(
                      minWidth: Get.width,
                      onPressed: () {
                        print('Login Button Clicked');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromRGBO(240, 148, 51, 1),
                        ),
                        // ! Button Width Mismatch
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                      height: 20,
                    ),
                    MaterialButton(
                      minWidth: Get.width,
                      onPressed: () {
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
                      height: 31,
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
