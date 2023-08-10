import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/functions/send_message.dart';
import '../models/message.dart';
import 'message_bubble.dart';
import 'message_bubble2.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  late TextEditingController textEditorController;
  late ScrollController scrollController;
  @override
  void initState() {
    textEditorController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    textEditorController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  final Stream<QuerySnapshot> _messagesStream = FirebaseFirestore.instance
      .collection(KMessagesCollection)
      .orderBy('timeStamp', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                // // log('rebuild');
                // // log(snapshot.connectionState)
                // snapshot.data!.docs.map((e) {
                //   log(e.toString());
                // });
                // for (var document in snapshot.data!.docs) {
                //   log(document.data().toString());
                // }
                List<Message> messages = [];
                if (snapshot.hasData) {
                  for (var document in snapshot.data!.docs) {
                    messages.add(Message.fromJson(
                        document.data() as Map<String, dynamic>));
                  }
                }

                return ListView.builder(
                  controller: scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: ((context, index) {
                    // return const SizedBox();
                    return getMessageBubble(messages[index]);
                  }),
                );
              }),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {
                // Perform attachment action
              },
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(),
                decoration: const InputDecoration(
                  hintText: 'Type your message',
                ),
                onSubmitted: (value) async {
                  String? avatar = await fetchAvatar();
                  String uid = FirebaseAuth.instance.currentUser!.uid;

                  Message messageModel = Message(
                      avatar: avatar!,
                      content: value,
                      timeStamp: Timestamp.now(),
                      SenderID: uid);

                  await SendMessage(messageModel);
                  textEditorController.clear();
                  scrollController.animateTo(0,
                      duration: const Duration(microseconds: 300),
                      curve: Curves.easeIn);
                },
              ),
            ),
            // IconButton(
            //   icon: const Icon(Icons.send),
            //   onPressed: () async {
            //     MessageModel messageModel = MessageModel(
            //         avatar: '',
            //         content: '',
            //         senderID: '',
            //         timeStamp: DateTime.now());

            //     await sendMessage(messageModel);
            //   },
            // ),
          ],
        ),
      ],
    );
  }

  Future<String?> fetchAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var avatar = prefs.getString(Kavatar);
    return avatar;
  }

  Widget getMessageBubble(Message message) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    if (uid == message.SenderID) {
      return SenderMessageBubble(messageModel: message);
    } else {
      return ReceiverMessageBubble(messageModel: message);
    }
  }
}
