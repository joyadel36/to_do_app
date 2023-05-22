
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color skyblue = Color.fromRGBO(135,206,235,1);
const Color salmon = Color.fromRGBO(250,128,114, 1);
const Color palegreen = Color.fromRGBO(152,251,152,1);
const Color white = Colors.white;
const primaryClr = skyblue;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);
const Color lightgray = Color.fromRGBO(220,220,220, 1);

class Themes {
  static final light=ThemeData(
    primaryColor:skyblue,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
  );
  static final dark=ThemeData(
    primaryColor:Colors.black,
    brightness: Brightness.dark,
    backgroundColor: darkHeaderClr,
  );

}
TextStyle get Headingstyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white :Colors.black ),
  );
}
TextStyle get SubHeadingstyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white :Colors.black ),
  );
}

TextStyle get Titlestyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.white :Colors.black ),
  );
}

TextStyle get SubTitlestyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.white : darkHeaderClr),
  );
}
TextStyle get Bodylestyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.black),
  );
}
TextStyle get Body2lestyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color:Get.isDarkMode ? Colors.white : darkHeaderClr),
  );
}