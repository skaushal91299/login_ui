import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Text Fields
Column textFields(
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
