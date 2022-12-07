import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ThemeSelectionButton extends StatelessWidget {
  final String title;
  final double btnWidth;
  final bool isSelected;
  final String iconPath;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onPressed;

  ThemeSelectionButton(
      {required this.title,
        required this.onPressed,
        required this.isSelected,
        required this.iconPath, required this.btnWidth, required this.foregroundColor, required this.backgroundColor, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      width: btnWidth,
      height: 80.0,
      child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 12))),
              SizedBox(
                width: 2,
              ),
            ],
          ),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(foregroundColor),
              backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(color: borderColor)))),
          onPressed: () => onPressed()),
    );
  }
}
