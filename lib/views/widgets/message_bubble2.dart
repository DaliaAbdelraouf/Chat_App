import 'package:flutter/material.dart';

import '../models/message.dart';

class ReceiverMessageBubble extends StatelessWidget {
  const ReceiverMessageBubble({super.key, required this.messageModel});

  final Message messageModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Image.asset(
            'assets/images/avatar_1.png',
          ),
        ),
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 40 - 8),
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              // bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(12),
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
      ],
    );
  }
}
