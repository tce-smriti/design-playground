import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../locales/locale_keys.g.dart';

class CustomHeaderView extends StatelessWidget {
  final String title;

  CustomHeaderView(
      {required this.title,
       });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0,right: 5.0),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(title,
                  style: GoogleFonts.poppins(
                      textStyle:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: kHomeHeaderColor)),
                  textAlign: TextAlign.left)),
          Spacer(),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("View all",
                  style: GoogleFonts.poppins(
                      textStyle:TextStyle(fontSize: 12,color: kHomeViewAllColor)),
                  textAlign: TextAlign.left)),
        ],
      )
    );
  }
}
