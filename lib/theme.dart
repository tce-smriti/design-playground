import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "IBMPlex",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headlineLarge: TextStyle(
      color: Color(0xFF000000),
      fontSize: 20,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
      fontFamily: "IBMPlex",
    ),
    bodyText1: TextStyle(
      color: kTextColor,
      fontSize: 16,
      letterSpacing: 0.5,
      fontFamily: "IBMPlex",
    ),
    bodyText2: TextStyle(
      color: Color(0xFF676767),
      fontSize: 16,
      letterSpacing: 0.5,
      fontFamily: "IBMPlex",
    ),
    headline4: TextStyle(
      color: kTextColor,
      fontSize: 14,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w600
    ),
    headline1: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 20,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
      fontFamily: "IBMPlex",
    ),
    subtitle2: TextStyle(
      color: Colors.black,
      fontSize: 28,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
      fontFamily: "IBMPlex",
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontSize: 14,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
      fontFamily: "IBMPlex",
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontSize: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.bold,
      fontFamily: "IBMPlex",
    ),
    headline5: TextStyle(
      color: kTextLightColor,
      fontSize: 12,
      letterSpacing: 0.15,
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
