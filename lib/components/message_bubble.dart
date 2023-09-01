import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message, this.fromMe = false,
  });

  final QueryDocumentSnapshot<Object?> message;
  final bool fromMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
      child: Column(
        crossAxisAlignment: fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message['sender'],
            style: const TextStyle(
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: fromMe ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(fromMe ? 15 : 0),topRight: Radius.circular(fromMe ? 0 : 15),bottomLeft: const Radius.circular(15), bottomRight: const Radius.circular(15)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(2, 2),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Text(
              message['text'],
              style: TextStyle(
                color: fromMe ? Colors.white : Colors.black54,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
