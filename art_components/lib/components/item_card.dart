library art_components;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/button_list.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final int cardHeight;
  final String subTitle;
  final String assetPath;
  final int imageType;
  final List<buttonList> btnList;
  final VoidCallback onPressed;

  ItemCard(
      {required this.title,
      required this.assetPath,
      required this.onPressed,
      required this.imageType, required this.cardHeight, required this.subTitle, required this.btnList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    width: 130,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                /*Expanded(
                      child: imageType == PNG_TYPE
                          ? Image.asset(assetPath)
                          : SvgPicture.asset(
                              assetPath,
                              fit: BoxFit.fill,
                            ),
                    )*/
              ],
            ),
          )),
    );
  }
}
