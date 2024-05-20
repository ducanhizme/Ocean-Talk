import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
    static ButtonStyle buildElevatedButtonFillStyle(Color color){
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  static OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:  const BorderSide(color: Colors.black)
    );
  }
}

