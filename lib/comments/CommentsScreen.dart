import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/main.dart';

class CommentsScreen extends StatefulWidget {
  static const String routeName = 'comments';

  @override
  CommentsScreenState createState() => CommentsScreenState();
}

class CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.backgroundColor,
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
                bottomLeft: Radius.circular(200))),
        title: Center(
          child: Text(
            'Comments',
            style: GoogleFonts.raleway(color: MyThemeData.white),
          ),
        ),
        backgroundColor: MyThemeData.lightBlue,
      ),
    );
  }
}