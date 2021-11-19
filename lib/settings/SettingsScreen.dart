import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/lastservices/LastServicesScreen.dart';
import 'package:home_maintenance/main.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'settings';

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final ImagePicker _picker = ImagePicker();
  late File imagex;
  String name = '';
  String address = '';
  String emailAddress = '';
  String phoneNumber = '';
  String userName = '';
  String userEmailAddress = '';

  String password = '';

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
        title: Center(child: Text('Settings')),
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
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        name,
                        style: GoogleFonts.raleway(
                            fontSize: 20, color: MyThemeData.lightBlue),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      InkWell(
                          onTap: updateUserName,
                          child: Icon(
                            Icons.edit,
                            color: MyThemeData.lightBlue,
                          )),
                      Spacer()
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        emailAddress,
                        style: GoogleFonts.raleway(
                            fontSize: 20, color: MyThemeData.lightBlue),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                      InkWell(
                          onTap: updateUserEmailAddress,
                          child: Icon(
                            Icons.edit,
                            color: MyThemeData.lightBlue,
                          )),
                      Spacer()
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(12)),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address,
                      style: GoogleFonts.raleway(
                          fontSize: 35, color: MyThemeData.lightBlue),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: updateUserName,
                      child: Icon(
                        Icons.edit,
                        color: MyThemeData.lightBlue,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Padding(padding: EdgeInsets.all(12)),
                Row(
                  children: [
                    Text(
                      phoneNumber,
                      style: GoogleFonts.raleway(
                          fontSize: 35, color: MyThemeData.lightBlue),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: updateUserName,
                      child: Icon(
                        Icons.edit,
                        color: MyThemeData.lightBlue,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Padding(padding: EdgeInsets.all(12)),
                Row(
                  children: [
                    Text(
                      'Password',
                      style: GoogleFonts.raleway(
                          fontSize: 35, color: MyThemeData.lightBlue),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: updateUserName,
                      child: Icon(
                        Icons.edit,
                        color: MyThemeData.lightBlue,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Padding(padding: EdgeInsets.all(15)),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    onPressed: onClickSettings,
                    label: Text(
                      'Sign Out',
                      style: GoogleFonts.raleway(),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(), primary: MyThemeData.lightBlue),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  onClickSettings() async {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  onClickLastServices() async {
    Navigator.pushNamed(context, LastServicesScreen.routeName);
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
                Positioned(
                    bottom: 18.0,
                    right: 18.0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => bottomSheet(),
                        );
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: MyThemeData.lightBlue,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
  editUserEmailAddress() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: TextFormField(
              style: GoogleFonts.raleway(color: MyThemeData.lightBlue),
              onChanged: (newValue) {
                userEmailAddress = newValue;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyThemeData.lightBlue)),
                  hintStyle: TextStyle(color: MyThemeData.lightBlue),
                  labelStyle: TextStyle(color: MyThemeData.lightBlue),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  fillColor: MyThemeData.lightBlue),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      emailAddress = userEmailAddress;
                      users
                          .doc(user)
                          .update({'emailAddress': userEmailAddress})
                          .then((value) => print("User Updated"))
                          .catchError((error) =>
                          print("Failed to update user: $error"));
                    });
                    Navigator.pop(context);
                    print(userEmailAddress);
                  },
                  child: Text('Done'))
            ],
          );
        });
  }
  editUserName() {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: TextFormField(
              style: GoogleFonts.raleway(color: MyThemeData.lightBlue),
              onChanged: (newValue) {
                userName = newValue;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyThemeData.lightBlue)),
                  hintStyle: TextStyle(color: MyThemeData.lightBlue),
                  labelStyle: TextStyle(color: MyThemeData.lightBlue),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  fillColor: MyThemeData.lightBlue),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      name = userName;
                      users
                          .doc(user)
                          .update({'name': userName})
                          .then((value) => print("User Updated"))
                          .catchError((error) =>
                              print("Failed to update user: $error"));
                    });
                    Navigator.pop(context);
                    print(userName);
                  },
                  child: Text('Done'))
            ],
          );
        });
  }

  final dp = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!.uid.toString();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserName() {
    return editUserName();
  }
  Future<void> updateUserEmailAddress() {
    return editUserEmailAddress();
  }
  getCurrentUserData() async {
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

  Future takePhoto(ImageSource source) async {
    var imagess = await _picker.pickImage(source: source);

    setState(() {
      imagex = File(imagess!.path);
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery'))
            ],
          ),
        ],
      ),
    );
  }
}
