import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/chat/ChatScreen.dart';
import 'package:home_maintenance/comments/CommentsScreen.dart';
import 'package:home_maintenance/main.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = 'category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  double rating = 0;
  double rating2 = 0;
  double rating3 = 0;
  String message = 'Message';
  String comments = 'Comments';
  String rate = 'Rate';
  String name = '',
      work = '',
      name1 = '',
      work1 = '',
      name2 = '',
      work2 = '';

  getWorkerData() {
    FirebaseFirestore.instance
        .collection('workers')
        .doc('LmsUAVZFwVtW7NuD1fch')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      work = documentSnapshot['work'];
      name = documentSnapshot['name'];
    });
    FirebaseFirestore.instance
        .collection('workers')
        .doc('JhgzxmodhGc3asRNZnVO')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      work1 = documentSnapshot['work'];
      name1 = documentSnapshot['name'];
    });
    FirebaseFirestore.instance
        .collection('workers')
        .doc('WtjVrBmgtkDNH0J6OGsj')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      this. work2 = documentSnapshot['work'];
      this.name2 = documentSnapshot['name'];
    });
  }
  @override
  void initState() {
    super.initState();
    getWorkerData();
  }

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
              children: <Widget>[
                Container(
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
                            work,
                            style: GoogleFonts.raleway(
                                color: MyThemeData.lightBlue),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            name1,
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
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
                              onTap: () => showRating(),
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
                          buildRating(),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage:
                            AssetImage('assets/images/carpenter.png'),
                          ),
                          Text(
                            work1,
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
                              onTap: () => showRating2(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating2',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          buildRating2(),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage:
                            AssetImage('assets/images/carpenter.png'),
                          ),
                          Text(
                            work2,
                            style: GoogleFonts.raleway(
                                color: MyThemeData.lightBlue),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            name2,
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                            'Name',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                            'Name',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
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
                              onTap: () => showRating(),
                              child: Text(
                                'Rate My Services',
                                style: GoogleFonts.raleway(
                                    fontSize: 15, color: MyThemeData.lightBlue),
                              )),
                          Text(
                            'Rating $rating3',
                            style: GoogleFonts.raleway(
                                fontSize: 15, color: MyThemeData.lightBlue),
                          ),
                          RatingBar.builder(
                            initialRating: rating3,
                            minRating: 1,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            itemSize: 20,
                            onRatingUpdate: (rating) =>
                                setState(() {
                                  this.rating3 = rating;
                                }),
                          ),
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
                        child: Icon(Icons.call, color: MyThemeData.lightBlue,),
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
              ],
            ),
          ),
        ));
  }

  Widget buildRating() =>
      RatingBar.builder(
        initialRating: rating,
        minRating: 1,
        itemBuilder: (context, _) =>
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
        updateOnDrag: true,
        itemSize: 20,
        onRatingUpdate: (rating) =>
            setState(() {
              this.rating = rating;
            }),
      );

  Widget buildRating2() =>
      RatingBar.builder(
        initialRating: rating2,
        minRating: 1,
        itemBuilder: (context, _) =>
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
        updateOnDrag: true,
        itemSize: 20,
        onRatingUpdate: (rating) =>
            setState(() {
              this.rating2 = rating;
            }),
      );
  final dp = FirebaseFirestore.instance;

  Future<void> getPhoneNumber() async {
    final user = FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        await FlutterPhoneDirectCaller.callNumber(
            documentSnapshot["phoneNumber"]);
        print('Document data: ${documentSnapshot["phoneNumber"]}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  onClickMessage() async {
    Navigator.pushNamed(context, ChatScreen.routeName);
  }

  onClickComments() async {
    Navigator.pushNamed(context, CommentsScreen.routeName);
  }

  showRating() =>
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(
                  'Say your Opinion',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Please, Leave a Star Rating',
                      style: GoogleFonts.raleway(
                          fontSize: 15, color: MyThemeData.lightBlue),
                    ),
                    buildRating(),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.raleway(
                            fontSize: 15, color: MyThemeData.lightBlue),
                      ))
                ],
              ));

  void showRating2() {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text(
                  'Say your Opinion',
                  style: GoogleFonts.raleway(
                      fontSize: 15, color: MyThemeData.lightBlue),
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Please, Leave a Star Rating',
                      style: GoogleFonts.raleway(
                          fontSize: 15, color: MyThemeData.lightBlue),
                    ),
                    buildRating2(),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Submit',
                        style: GoogleFonts.raleway(
                            fontSize: 15, color: MyThemeData.lightBlue),
                      ))
                ],
              ));
}
}
