import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/button_list.dart';

class QuickTipsCard extends StatelessWidget {
  final String title;
  final int cardHeight;
  final String subTitle;
  final String assetPath;
  final int imageType;
  final bool isRenewal;
  final VoidCallback onPressed;

  QuickTipsCard(
      {required this.title,
      required this.assetPath,
      required this.onPressed,
      required this.imageType,
      required this.cardHeight,
      required this.subTitle,
      required this.isRenewal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 5,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: SvgPicture.asset(
                      assetPath,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(title,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 13, fontWeight:FontWeight.bold,color: Color(0xFF1F4280))),
                              textAlign: TextAlign.left)),
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text.",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF7B7B7B))),
                                textAlign: TextAlign.left)),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}

class RenewalButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
      child: ElevatedButton(
          child: Text("Renewal",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 12))),
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(kRenewalBtnForeColor),
              backgroundColor:
                  MaterialStateProperty.all<Color>(kRenewalBtnBackColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                      side: BorderSide(color: kRenewalBtnBackColor)))),
          onPressed: () {}),
    );
  }
}
