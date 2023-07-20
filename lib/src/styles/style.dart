
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgCol = Color.fromARGB(255, 241, 237, 237);
  static Color mainColor = Color(0xFF000633);
  static Color accentColor = Color(0xFF0065FF);
  
  static List<ThemeData> cardsColor = [
    ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),),
    ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink),),
    ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),),
    ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),),
    ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),),
    ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),),
  ];
  
  static TextStyle mainTitle = GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.bold);
  static TextStyle mainContent = GoogleFonts.nunito(fontSize: 18.0, fontWeight: FontWeight.normal);
  static TextStyle dateTitle = GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.normal);
  
}