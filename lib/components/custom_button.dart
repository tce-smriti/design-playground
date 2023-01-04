import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double btnWidth;
  final bool isSelected;
  final String iconPath;
  final VoidCallback onPressed;

  CustomButton(
      {required this.title,
      required this.onPressed,
      required this.isSelected,
      required this.iconPath, required this.btnWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      width: btnWidth,
      height: 50.0,
      child: isSelected
          ? ElevatedButton(
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(kBtnTextColorSelected),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kBtnColorSelected),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          side: BorderSide(color: kBtnBorderColor,width: 1.0)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 12))),
                  SizedBox(
                    width: 2,
                  ),
                  SvgPicture.asset(
                    iconPath,
                    width: 15,
                    height: 15,
                  ),
                ],
              ),
              onPressed: () => onPressed())
          : ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 12))),
                  SizedBox(
                    width: 2,
                  ),
                  SvgPicture.asset(
                    iconPath,
                    width: 15,
                    height: 15,
                  ),
                ],
              ),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(kBtnTextColorNotSelected),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kBtnColorNotSelected),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          side: BorderSide(color: kBtnColorNotSelected)))),
              onPressed: () => onPressed()),
    );
  }
}
