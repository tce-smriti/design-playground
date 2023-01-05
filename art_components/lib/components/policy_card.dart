library art_components;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../locales/locale_keys.g.dart';
import '../models/button_list.dart';

class PolicyCard extends StatelessWidget {
  final String title;
  final int cardHeight;
  final String subTitle;
  final String assetPath;
  final int imageType;
  final bool isRenewal;
  final VoidCallback onPressed;

  PolicyCard(
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
      child: isRenewal
          ? Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              width: 170,
              height: 200,
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
                      Positioned(
                          top: 25,
                          left: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(title,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: kPolicyCardTextColor)),
                                      textAlign: TextAlign.left)),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(LocaleKeys.Insurance.tr(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: kPolicyCardTextColor)),
                                      textAlign: TextAlign.left)),
                            ],
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        child: Text("1",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                        kPolicyCardTextColor)),
                                            textAlign: TextAlign.left)),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, top: 5),
                                        child: Text("Policies",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        kPolicyCardTextColor)),
                                            textAlign: TextAlign.start)),
                                  ],
                                ),
                                RenewalButton()
                              ],
                            ),
                          )),
                    ],
                  )))
          : Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 30),
              width: 170,
              height: 200,
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
                      Positioned(
                          top: 25,
                          left: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(title,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: kPolicyCardTextColor)),
                                      textAlign: TextAlign.left)),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(LocaleKeys.Insurance.tr(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: kPolicyCardTextColor)),
                                      textAlign: TextAlign.left)),
                            ],
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        child: Text("1",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color:
                                                        kPolicyCardTextColor)),
                                            textAlign: TextAlign.left)),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 1, top: 5,right: 1),
                                        child: Text("Policies",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        kPolicyCardTextColor)),
                                            textAlign: TextAlign.start)),
                                  ],
                                ),
                                // RenewalButton()
                              ],
                            ),
                          )),
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
      padding: EdgeInsets.only(left: 10.0, bottom: 5.0,right: 10),
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

class HeaderButton extends StatelessWidget {
  final String title;

  HeaderButton({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: 10),child: Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Text(title,
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 12),color: kHeaderColor)),
          SizedBox(width: 4,),
          Text("7",
              style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 12),color: notificationTextCount))
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: notificationTabCircle,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: notificationTabCircle,
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),);
  }
}
