import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_maintenance/main.dart';
final fireStore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const String routeName = 'Chat';

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final messageTextController=TextEditingController();
  final user = FirebaseAuth.instance.currentUser!.email;
  String? messageText;
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
              Text('Carpenter')
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
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
                            messagesStreams();
                            fireStore
                                .collection('messages')
                                .add({'text': messageText, 'sender': user});
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
        ));
  }

  /*void getMessages()async {
    final messages = await fireStore.collection('messages').get();
    for(var message in messages.docs){
      print(message.data());
    }
  }*/
  void messagesStreams() async {
    await for (var snapshot in fireStore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
}
class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> massagewidgets = [];
        if (!snapshot.hasData) {}
        final messages = snapshot.data!.docs;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messagewidget = MessageLine(sender: messageSender,text: messageText,);
          massagewidgets.add(messagewidget);
        }
        return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
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
  const MessageLine({this.text,this.sender ,Key? key}) : super(key: key);
final String? sender;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      Text('$sender',style: GoogleFonts.raleway(fontSize: 10.0,color: MyThemeData.lightBlue),),
      Material(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding:
          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: MyThemeData.lightBlue,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          child: Text(
            '$text',
            style: GoogleFonts.raleway(color: MyThemeData.backgroundColor),
          ),
        ),
      ),),],));
  }
}
