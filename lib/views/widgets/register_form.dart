import 'package:chat_app/views/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/register_cubit/register_cubit.dart';
import 'avatars_list.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  late String emailAddress;
  late String password, name;
  UserModel userModel = UserModel();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Future<void> addUser() {
    //   // Call the user's CollectionReference to add a new user
    //   return users
    //       .add({
    //         'Email': emailAddress, // John Doe
    //         'password': password, // Stokes and Sons
    //       })
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }

    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          CustomTextFormField(
            onSaved: (value) {
              name = value!;
            },
            // hintText: 'Enter your name',
            hintText: 'Enter your name',
            //  hintText: ('Enter your name', style: TextStyle(color: Colors.blue)),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            onSaved: (value) {
              emailAddress = value!;
            },
            hintText: 'Enter your email',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            onSaved: (value) {
              password = value!;
            },
            hintText: 'Enter your password',
          ),
          const SizedBox(
            height: 16,
          ),
          AvatarListWidget(
            userModel: userModel,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                UserModel userModel = UserModel(
                  name: name,
                  email: emailAddress,
                  avatar: 'assets/images/avatar_1.png',
                  dateTime: DateTime.now(),
                );
                BlocProvider.of<RegisterCubit>(context)
                    .register(userModel: userModel, password: password);
              } else {
                setState(() {
                  _autoValidateMode = AutovalidateMode.always;
                });
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
