// ignore_for_file: avoid_print, constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'login_success.dart';

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }

login(
  String email,
  password,
  // deviceType,
  // deviceToken,
) async {
  try {
    var url = Uri.parse('https://php.parastechnologies.in/groupthnk/api/login');
    var response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
        'deviceType': 'Android',
        'deviceToken': 'jkgjskjgsjg',
      },
    );
    print(response);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      if (data["success"] == 1) {
        print(data);
        snackBar('Login successfully');
        return Get.to(() => const LoginSuccess());
      } else {
        snackBar("Please Enter Valid Credentials");
      }
    } else {
      print('failed');
      return Get.snackbar(
        'Error',
        "Internal server error",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        icon: const Icon(Icons.dangerous),
        backgroundColor: const Color.fromARGB(255, 242, 74, 63),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

snackBar(
  String message,
) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.black,
    backgroundColor: const Color.fromRGBO(240, 148, 51, 1),
    icon: const Icon(Icons.dangerous),
    duration: const Duration(seconds: 1),
    animationDuration: const Duration(seconds: 1),
  );
}
