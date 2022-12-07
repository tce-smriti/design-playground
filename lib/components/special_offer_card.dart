import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../models/button_list.dart';

class SpecialOfferCard extends StatelessWidget {
  SpecialOfferCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        width: 300,
        height: 200,
        child: Image.asset('assets/icons/special_offers.png',fit: BoxFit.fitWidth,),
      ),
    );
  }
}
