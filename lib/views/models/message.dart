import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String content;
  final String avatar;
  final String SenderID;
  final Timestamp timeStamp;
  Message({
    required this.content,
    required this.avatar,
    required this.SenderID,
    required this.timeStamp,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      avatar: json['avatar'],
      SenderID: json['senderID'],
      timeStamp: Timestamp.now(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'avatar': avatar,
      'senderID': 'SenderID',
      'timeStamp': timeStamp,
    };
  }
}
