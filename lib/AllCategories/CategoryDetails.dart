import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/main.dart';

class CategoryDetails extends StatelessWidget {
  CategoryDetails(
      {required this.name,
        required this.rating,
        required this.onClickMessage,
        required this.showRating,
        required this.buildRating,
        required this.onClickComments,
        required this.getPhoneNumber,});
  String name, comments='Comments',message='Message';
  double rating;
  var onClickMessage;
  var onClickComments;
  var getPhoneNumber;
  var showRating;
  var buildRating;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30),
      decoration: BoxDecoration(color: MyThemeData.white),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage:
                AssetImage('assets/images/carpenter.png'),
              ),
              Text(
                'Carpenter',
                style: GoogleFonts.raleway(
                    color: MyThemeData.lightBlue),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              Text(
                name,
                style: GoogleFonts.raleway(
                    fontSize: 15, color: MyThemeData.lightBlue),
              ),
              const SizedBox(
                height: 1,
              ),
              GestureDetector(
                onTap: onClickMessage,
                child: Text(
                  message,
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              GestureDetector(
                  onTap: () => showRating,
                  child: Text(
                    'Rate My Services',
                    style: GoogleFonts.raleway(
                        fontSize: 15, color: MyThemeData.lightBlue),
                  )),
              Text(
                'Rating $rating',
                style: GoogleFonts.raleway(
                    fontSize: 15, color: MyThemeData.lightBlue),
              ),
              buildRating,
              GestureDetector(
                onTap: onClickComments,
                child: Text(
                  comments,
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: getPhoneNumber,
            child: Icon(Icons.call),
          )
        ],
      ),
    );
  }
}