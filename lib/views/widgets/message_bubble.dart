import 'package:flutter/material.dart';

import '../models/message.dart';

class SenderMessageBubble extends StatelessWidget {
  const SenderMessageBubble({super.key, required this.messageModel});

  final Message messageModel;
  @override
  Widget build(BuildContext context) {
    // return Text(messageModel.content);
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Text(
          messageModel.content,
          style: const TextStyle(
            color: Colors.white,

            // maxLines:2,
          ),
        ),
      ),
    );
  }
}
