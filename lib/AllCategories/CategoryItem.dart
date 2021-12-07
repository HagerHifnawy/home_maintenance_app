import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/main.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem(
      {required this.imagePath,
      required this.backGroundColor,
      required this.text,
      required this.rightSided});
  String imagePath, text;
  Color backGroundColor;
  bool rightSided;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 30,bottom: 30),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomLeft: rightSided ? Radius.circular(30) : Radius.circular(0),
              bottomRight:
                  rightSided ? Radius.circular(0) : Radius.circular(30))),
      child: Column(
        children: [
          Image.asset('$imagePath'),
          Text(
            '$text',
            style: GoogleFonts.raleway(fontSize: 20, color: MyThemeData.black),
          ),
        ],
      ),
    );
  }
}
