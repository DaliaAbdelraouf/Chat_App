import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/utils/functions/fetch_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  LoginCubitCubit() : super(LoginCubitInitial());

  void login({required String email, required String password}) async {
    emit(LoginCubitLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await fetchUserData(userCredential: credential);
      var userData = await fetchUserData(userCredential: credential);

     // Obtain shared preferences.
      await saveAvatarLocal(userData);

      emit(LoginCubitSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        LoginCubitFailure('user not found please try again');
      } else if (e.code == 'wrong-password') {
        LoginCubitFailure('wrong password');
      }
    }
  }
  Future<void> saveAvatarLocal(UserModel userData) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save an String value to 'action' key.
    await prefs.setString(Kavatar, userData.avatar!);
  }
}


