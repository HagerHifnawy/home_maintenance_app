import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/chat/ChatScreen.dart';
import 'package:home_maintenance/comments/CommentsScreen.dart';
import 'package:home_maintenance/main.dart';
import 'package:home_maintenance/rating/RateScreen.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String name = 'Name';
  String message = 'Message';
  String comments= 'Comments';
  String rate = 'Rate';
  String phoneNumber = 'Phone Number';
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
              'Category',
              style: GoogleFonts.raleway(color: MyThemeData.white),
            ),
          ),
          backgroundColor: MyThemeData.lightBlue,
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: MyThemeData.backgroundColor),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
            Container(
            padding: EdgeInsets.only(right: 30, left: 30),
            decoration: BoxDecoration(color: MyThemeData.white),
            child: Row(
              children: [
                Image.asset ('assets/images/carpenter.png'),
                Spacer(),
                Column(
                  children: [
                    Text(name,
                      style: GoogleFonts.raleway(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: getPhoneNumber,
                      child: Text(phoneNumber,
                        style: GoogleFonts.raleway(fontSize: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: onClickMessage,
                      child: Text(message,
                        style: GoogleFonts.raleway(fontSize: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: onClickRate,
                      child: Text(rate,
                        style: GoogleFonts.raleway(fontSize: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: onClickComments,
                      child: Text(comments,
                        style: GoogleFonts.raleway(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: onClickComments,
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  decoration: BoxDecoration(color: MyThemeData.white),
                  child: Row(
                    children: [
                      Image.asset ('assets/images/carpenter.png'),
                      Spacer(),
                      Column(
                        children: [
                          Text(name,
                            style: GoogleFonts.raleway(fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: getPhoneNumber,
                            child: Text(phoneNumber,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickMessage,
                            child: Text(message,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickRate,
                            child: Text(rate,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                          GestureDetector(
                            onTap: onClickComments,
                            child: Text(comments,
                              style: GoogleFonts.raleway(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClickComments,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
          ),
        )
    );
  }


  final dp = FirebaseFirestore.instance;

  Future <void> getPhoneNumber() async {
    final user = FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        await FlutterPhoneDirectCaller.callNumber(documentSnapshot["phoneNumber"]);
        print('Document data: ${documentSnapshot["phoneNumber"]}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }
   onClickMessage()async{
    Navigator.pushNamed(context, ChatScreen.routeName);
  }
  onClickComments()async{
    Navigator.pushNamed(context, CommentsScreen.routeName);
  }
  onClickRate()async{
    Navigator.pushNamed(context, RateScreen.routeName);
  }
}
