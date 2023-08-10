import 'package:chat_app/views/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserModel> fetchUserData(
    {required UserCredential userCredential}) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection(KuserCollection);

  var doc = await users.doc(userCredential.user!.uid).get();
  UserModel userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
  return userModel;
}
