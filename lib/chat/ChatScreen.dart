import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/main.dart';

final fireStore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser!.email;

class ChatScreen extends StatefulWidget {
  static const String routeName = 'Chat';

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String? messageText;
  String name = '',
      name1 = '',
      name2= '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorkerData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('assets/images/carpenter.png'),
              ),
              SizedBox(
                width: 20.0,
              ),
             Text('Adham Hifnawy',style: GoogleFonts.raleway(color: MyThemeData.white),)
            
            ],
          ),
        ),
        body: Column(
            children: [
              MessageStreamBuilder(),
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
                      controller: messageTextController,
                      onChanged: (newvalue) {
                        messageText = newvalue;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tybe Your Message...'),
                    )),
                    Container(
                      height: 40.0,
                      child: MaterialButton(
                          minWidth: 1.0,
                          color: MyThemeData.lightBlue,
                          onPressed: () {
                            messageTextController.clear();
                            fireStore
                                .collection('messages')
                                .add({'text': messageText, 'sender': user,'time':FieldValue.serverTimestamp()});
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
        );
  }
  getWorkerData() async {
    FirebaseFirestore.instance
        .collection('workers')
        .doc('LmsUAVZFwVtW7NuD1fch')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      name = documentSnapshot['name'];
    });
    FirebaseFirestore.instance
        .collection('workers')
        .doc('JhgzxmodhGc3asRNZnVO')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      name1 = documentSnapshot['name'];

    });
    FirebaseFirestore.instance
        .collection('workers')
        .doc('WtjVrBmgtkDNH0J6OGsj')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      print('Document data: ${documentSnapshot.data()}');
      name2 = documentSnapshot['name'];
    });
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> massagewidgets = [];
        if (!snapshot.hasData) {}
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = user;
          if (currentUser == messageSender) {}
          final messagewidget = MessageLine(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          massagewidgets.add(messagewidget);
        }
        return Expanded(
            child: ListView(
              reverse: true,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: [
            Column(
              children: massagewidgets,
            )
          ],
        ));
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, required this.isMe, Key? key})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(
              '$sender',
              style: GoogleFonts.raleway(
                  fontSize: 10.0, color: MyThemeData.lightBlue),
            ),
            Material(
              child: Align(
                alignment: isMe?AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: isMe?MyThemeData.lightBlue:MyThemeData.backgroundColor,
                      borderRadius: isMe?BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10.0),
                        topEnd: Radius.circular(10.0),
                        topStart: Radius.circular(10.0),
                      ):BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10.0),
                        topEnd: Radius.circular(10.0),
                        topStart: Radius.circular(10.0),),),
                  child: Text(
                    '$text',
                    style:
                        GoogleFonts.raleway(color: isMe?MyThemeData.backgroundColor:MyThemeData.lightBlue),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

}
