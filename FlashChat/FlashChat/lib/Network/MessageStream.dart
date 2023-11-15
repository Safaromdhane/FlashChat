import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Components/MessageBubble.dart';
final _firestore = FirebaseFirestore.instance;
class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key, required this.loggedinU}) : super(key: key);
  final User loggedinU;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Messages').snapshots(),
      builder: (context,snapshot){
        List<MessageBubble> messagesBubbles = [];
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for(var message in messages!){
          final Map<String, dynamic> data = message.data() as Map<String, dynamic>;
          final String sender  = data['Sender'];
          final String text = data ['text'];


          final currentUser = loggedinU.email;


          final messageBubble = MessageBubble(text: text,sender: sender,isMe: currentUser == sender,);
          messagesBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            children: messagesBubbles,
          ),
        );
      },
    );
  }
}