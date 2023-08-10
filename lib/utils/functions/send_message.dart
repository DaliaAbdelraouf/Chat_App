import 'dart:math';

import 'package:chat_app/constants.dart';
import 'package:chat_app/views/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> SendMessage(Message message) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messages = firestore.collection(KMessagesCollection);

    await messages.add(message.toJson());
  } on Exception catch (e) {
    print(e);
  }
}
