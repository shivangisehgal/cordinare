import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteColor {
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFFF35588);

  //setting the card in different color

  static List<Color> cardColor = [
    Colors.red.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.pink.shade100,
    Colors.deepPurple.shade100,
    Colors.blueGrey.shade100,
  ];

  //setting the text style
  static TextStyle mainTitle =
      GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600);
  static TextStyle mainContent =
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.normal);
  static TextStyle dateTitle =
      GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500);
}
