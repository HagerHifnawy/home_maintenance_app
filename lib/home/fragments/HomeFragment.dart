import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/AllCategories/CategoryItem.dart';
import 'package:home_maintenance/AllCategories/categories/CategoryScreen.dart';
import 'package:home_maintenance/home/location/MapScreen.dart';
import 'package:home_maintenance/main.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
                bottomLeft: Radius.circular(200))),
        title: Center(
            child: Text(
          'Home Maintenance App',
          style: GoogleFonts.raleway(color: MyThemeData.white),
        )),
        backgroundColor: MyThemeData.lightBlue,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Stack(children: [
              Center(
                child: TextButton(
                    onPressed: onClickMap,
                    child: Image.asset('assets/images/map.png')),
              ),
              Center(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: MyThemeData.white),
                    onPressed: onClickMap,
                    icon: FaIcon(
                      FontAwesomeIcons.search,
                      color: MyThemeData.black,
                    ),
                    label: Text(
                      'What are you looking for?',
                      style: TextStyle(color: MyThemeData.black),
                    )),
              ),
            ]),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text(
                    'Meet Your Service At Home.',
                    style: GoogleFonts.raleway(
                        fontSize: 40, color: MyThemeData.black),
                  )),
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onClickCategory,
                      child: CategoryItem(
                          imagePath: 'assets/images/carpenter.png',
                          backGroundColor: MyThemeData.pink,
                          text: 'Carpenter',
                          rightSided: true),
                    ),
                    GestureDetector(
                      onTap: onClickCategory,
                      child: CategoryItem(
                          imagePath: 'assets/images/carpenter.png',
                          backGroundColor: MyThemeData.blue,
                          text: 'Carpenter',
                          rightSided: false),
                    ),
                    CategoryItem(
                        imagePath: 'assets/images/carpenter.png',
                        backGroundColor: MyThemeData.pink,
                        text: 'Carpenter',
                        rightSided: true),
                    CategoryItem(
                        imagePath: 'assets/images/carpenter.png',
                        backGroundColor: MyThemeData.blue,
                        text: 'Carpenter',
                        rightSided: false),
                    CategoryItem(
                        imagePath: 'assets/images/carpenter.png',
                        backGroundColor: MyThemeData.pink,
                        text: 'Carpenter',
                        rightSided: true),
                    CategoryItem(
                        imagePath: 'assets/images/carpenter.png',
                        backGroundColor: MyThemeData.blue,
                        text: 'Carpenter',
                        rightSided: false)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onClickMap() {
    Navigator.pushNamed(context, MapScreen.routeName);
  }

  void onClickCategory() {
    Navigator.pushNamed(context, CategoryScreen.routeName);
  }
}
