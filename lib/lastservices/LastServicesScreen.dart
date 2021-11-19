import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/main.dart';

class LastServicesScreen extends StatefulWidget {
  static const String routeName = 'lastservices';

  @override
  LastServicesScreenState createState() => LastServicesScreenState();
}

class LastServicesScreenState extends State<LastServicesScreen> {
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
            'Last Services',
            style: GoogleFonts.raleway(color: MyThemeData.white),
          ),
        ),
        backgroundColor: MyThemeData.lightBlue,
      ),
    );
  }
}