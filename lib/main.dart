import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/login_view.dart';
import 'package:chat_app/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chatty());
}

class Chatty extends StatelessWidget {
  const Chatty({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: kPrimarySwatch,
          brightness: Brightness.dark,
          fontFamily: 'Inter',
        ),
        routes: {
          LoginView.id: (context) => const LoginView(),
          RegisterView.id: (context) => const RegisterView(),
          ChatView.id: (context) => const ChatView()
        },
        initialRoute: getInitialView());
  }

  String getInitialView() {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var isLoggedIn = prefs.containsKey('isLoggedIn');
    // if (isLoggedIn) {
    //   return ChatView.id;
    // } else {
    //   return LoginView.id;
    // }

    if (FirebaseAuth.instance.currentUser != null) {
      return LoginView.id;
    } else {
      return ChatView.id;
    }
  }
}
