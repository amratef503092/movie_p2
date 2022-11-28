import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {Key? key,
      required this.receiverId,
      required this.receiverName,
      required this.cinema,
      required this.cinemaID,
      required this.userID})
      : super(key: key);
  String receiverId;
  String receiverName;
  String userID;
  String cinemaID;
  bool cinema;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

TextEditingController messageController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Messages')
              .where('User', isEqualTo: widget.userID)
              .where('cinema', isEqualTo: widget.cinemaID)
              .orderBy('date')
              .snapshots(),
          builder: (context, snapshot) {
            print(widget.cinema);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final messages = snapshot.data!.docs.reversed;
              List<MessageLine> messageWidgets = [];

              for (var message in messages) {

                final messageText = message.get('message');

                messageWidgets.add(MessageLine
                  (
                  isMe: message['SenderID'] ==
                      FirebaseAuth.instance.currentUser!.uid,
                  date: message['date'],
                  messageID: message.id,
                  messageText: message['message'],
                  sender: message['SenderName'],
                ));
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ListView(
                  reverse: true,
                  children: messageWidgets,
                ),
              );
            }
          }),
      bottomSheet: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (messageController.text == '') {
                  return;
                } else {
                  await FirebaseFirestore.instance.collection('Messages').add({
                    'message': messageController.text,
                    'userID': FirebaseAuth.instance.currentUser!.uid,
                    "receiverId": widget.receiverId,
                    "receiverName": widget.receiverName,
                    "SenderName": AuthCubit.get(context).userModel!.name,
                    "SenderID": FirebaseAuth.instance.currentUser!.uid,
                    'date': DateTime.now().toString(),
                    "User": widget.userID,
                    "cinema": widget.cinemaID,
                  });
                  if (kDebugMode) {
                    print('Send');
                    messageController.clear();
                  }
                }
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  MessageLine(
      {super.key, this.messageText,
      this.sender,
      required this.date,
      this.isMe,
      required this.messageID});

  String? messageText;
  String? sender;
  String? date;

  bool? isMe;
  String? messageID;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.parse(date.toString());

    return (isMe!)
        ? InkWell(
            onTap: () async {
              if (DateTime.now().difference(now).inSeconds > 30) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("can not delete Message")));
              } else {
                await FirebaseFirestore.instance
                    .collection('Messages')
                    .doc(messageID)
                    .delete();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$sender',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text('$messageText',
                            style:
                                const TextStyle(color: Colors.black, fontSize: 14)),
                      ),
                    ),
                    Text(
                      DateFormat.yMEd().add_jms().format(DateTime.parse(date!)),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(22),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$sender', style: TextStyle(color: Colors.white)),
                  Material(
                    elevation: 2,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: RED_COLOR,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        '$messageText',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    DateFormat.yMEd().add_jms().format(DateTime.parse(date!)),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
