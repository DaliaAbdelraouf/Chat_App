import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/cubits/login_cubit/login_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_button.dart';
import 'custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  late String emailAddress;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          CustomTextFormField(
            onSaved: (value) {
              emailAddress = value!.trim();
            },
            hintText: 'Enter your email',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            onSaved: (value) {
              password = value!.trim();
            },
            hintText: 'Enter your password',
          ),
          const SizedBox(
            height: 36,
          ),
          CustomButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                BlocProvider.of<LoginCubitCubit>(context)
                    .login(email: emailAddress, password: password);

                // _formKey.currentState.reset();
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
