import 'package:bloc/bloc.dart';
import 'package:chat_app/utils/functions/store_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  void register(
      {required UserModel userModel, required String password}) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
     await storeUserData(credential, userModel);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('password is weak'));
      } else if (e.code == 'email-already-in-use') {
        // log('The account already exists for that email.');
        emit(RegisterFailure('email already in use'));
      }
    } catch (e) {
      // print(e);
      emit(RegisterFailure('Failed to register, try again later.'));
    }
  }
}
