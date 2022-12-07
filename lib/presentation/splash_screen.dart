import 'package:art_flutter/presentation/customize_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _slashView();
}

class _slashView extends State<SplashScreen> {
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomizeScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Al Rajhi Takaful",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: kHeaderColor,
                              fontWeight: FontWeight.bold)),
                      textAlign: TextAlign.left)),
              Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/icons/logo-horizontal.svg",
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
