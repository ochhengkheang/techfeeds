import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class articleTextField extends StatelessWidget {
  articleTextField({
    Key? key,
    required this.darkBlue,
    required this.lightGreen,
    required this.controller,
    required this.title,
    required this.maxLine,
  }) : super(key: key);

  final Color darkBlue;
  final Color lightGreen;
  var controller;
  var title;
  var maxLine;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      maxLines: maxLine,
      controller: controller,
      decoration: InputDecoration(
        fillColor: darkBlue,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: darkBlue, width: 2),
            borderRadius: BorderRadius.circular(20)),
        labelStyle: TextStyle(
            color: lightGreen,
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600),
        labelText: title,
      ),
    );
  }
}
