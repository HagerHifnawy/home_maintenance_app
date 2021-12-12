import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/chat/ChatScreen.dart';
import 'package:home_maintenance/main.dart';

class CommentsScreen extends StatefulWidget {
  static const String routeName = 'comments';

  @override
  CommentsScreenState createState() => CommentsScreenState();
}

class CommentsScreenState extends State<CommentsScreen> {
  final commentsTextController = TextEditingController();
  String? commentText;


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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: MyThemeData.backgroundColor,
                    width: 1.0,
                  )),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: commentsTextController,
                        onChanged: (newvalue) {
                          commentText = newvalue;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tybe Your Comments...'),
                      )),
                  Container(
                    height: 40.0,
                    child: MaterialButton(
                        minWidth: 1.0,
                        color: MyThemeData.lightBlue,
                        onPressed: () {
                          commentsTextController.clear();
                          fireStore
                              .collection('comments')
                              .add({'text': commentText, 'sender': user,'time':FieldValue.serverTimestamp()});
                        },
                        child: Icon(
                          Icons.send,
                          size: 16.0,
                          color: MyThemeData.backgroundColor,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('comments').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<CommentLine> commentwidgets = [];
        if (!snapshot.hasData) {}
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = user;
          if (currentUser == messageSender) {}
          final Commentwidget = CommentLine(
            sender: messageSender,
            text: messageText,
          );
          commentwidgets.add(Commentwidget);
        }
        return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: [
                Column(
                  children: commentwidgets,
                )
              ],
            ));
      },
    );
  }
}
class CommentLine extends StatelessWidget {
const CommentLine({this.text, this.sender,  Key? key})
: super(key: key);
final String? sender;
final String? text;

@override
Widget build(BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$sender',
            style: GoogleFonts.raleway(
                fontSize: 10.0, color: MyThemeData.lightBlue),
          ),
          Material(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: MyThemeData.lightBlue,
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0))
            ),
                child: Text(
                  '$text',
                  style:
                  GoogleFonts.raleway(color:MyThemeData.lightBlue),
                ),
              ),
            ),
          ),
        ],
      ));
}

}
