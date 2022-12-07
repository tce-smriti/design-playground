import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/button_list.dart';

class ServicesCard extends StatelessWidget {
  final String title;
  final int cardHeight;
  final Color titleColor;
  final String subTitle;
  final String assetPath;
  final int imageType;
  final int cardType;
  final VoidCallback onPressed;

  ServicesCard(
      {required this.title,
      required this.assetPath,
      required this.onPressed,
      required this.imageType,
      required this.cardHeight,
      required this.subTitle,
      required this.cardType, required this.titleColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: cardType == 1
          ? Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: MediaQuery.of(context).size.width / 2,
              height: 160,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            assetPath,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 100,
                            height: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(title,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: titleColor)),
                                        textAlign: TextAlign.left)),
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(subTitle,
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: titleColor)),
                                        textAlign: TextAlign.left)),
                              ],
                            )),
                          )
                    ],
                  )))
          : Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: MediaQuery.of(context).size.width / 2,
              height: 80,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 10,top: 10),
                              child: Text(title,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: titleColor)),
                                  textAlign: TextAlign.left)),
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(subTitle,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: titleColor)),
                                  textAlign: TextAlign.left)),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            assetPath,
                            width: 25,
                            height: 25,
                          ),
                        ),
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
