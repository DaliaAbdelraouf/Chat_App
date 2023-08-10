import 'package:chat_app/constants.dart';
import 'package:chat_app/views/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

 Future<void> storeUserData(UserCredential userCredential,UserModel userModel) async{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = firestore.collection(KuserCollection);


    await users.doc(userCredential.user!.uid).set(userModel.toJson());
    
}
