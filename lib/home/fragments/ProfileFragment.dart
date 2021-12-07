import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/AllCategories/categories/CategoryScreen.dart';
import 'package:home_maintenance/main.dart';

class ProfileFragment extends StatefulWidget {
  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  String name = '';
  String address = '';
  String emailAddress = '';
  String phoneNumber = '';
  @override
  void initState() {
    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(200),
                bottomLeft: Radius.circular(200))),
        title: Center(child: Text('My Profile')),
        backgroundColor: MyThemeData.lightBlue,
      ),
      body: ListView(
        children: <Widget>[
          imageProfile(),
          Container(
            child: Center(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    name,
                    style: GoogleFonts.raleway(
                        fontSize: 20, color: MyThemeData.lightBlue),
                  ),
                  Padding(padding: EdgeInsets.all(7)),
                  Text(emailAddress,
                      style: GoogleFonts.raleway(
                          fontSize: 20, color: MyThemeData.lightBlue)),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address,
                  style: GoogleFonts.raleway(
                      fontSize: 35, color: MyThemeData.lightBlue),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Text(
                  phoneNumber,
                  style: GoogleFonts.raleway(
                      fontSize: 35, color: MyThemeData.lightBlue),
                ),
                Padding(padding: EdgeInsets.all(15)),
                GestureDetector(
                  onTap: onClickLastServices,
                  child: Text(
                    'Last Services',
                    style: GoogleFonts.raleway(
                        fontSize: 35, color: MyThemeData.lightBlue),
                  ),),

                Padding(padding: EdgeInsets.all(12)),

              ],
            ),
          )
        ],
      ),
    );
  }
  Widget imageProfile() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/carpenter.png'),
                  radius: 95.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onClickLastServices()async{
    Navigator.pushNamed(context, CategoryScreen.routeName);
  }
  final dp = FirebaseFirestore.instance;
  getCurrentUserData() async {
    final user = FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      setState(() {
        name = documentSnapshot['name'];
        address = documentSnapshot['address'];
        phoneNumber = documentSnapshot['phoneNumber'];
        emailAddress = documentSnapshot['emailAddress'];
      });
    });
  }
}
