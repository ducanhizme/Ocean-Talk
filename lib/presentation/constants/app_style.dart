import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButtonStyle{
    static ButtonStyle elevatedButtonFillPrimaryColorStyle(BuildContext context){
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

