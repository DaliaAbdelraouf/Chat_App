part of 'login_cubit_cubit.dart';

@immutable
abstract class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginCubitLoading extends LoginCubitState {}

class LoginCubitSuccess extends LoginCubitState {
  late final UserModel userModel;
}

class LoginCubitFailure extends LoginCubitState {
  final String errmessage;
  LoginCubitFailure(this.errmessage);
}
