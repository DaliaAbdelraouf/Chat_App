import 'package:chat_app/views/cubits/login_cubit/login_cubit_cubit.dart';
import 'package:chat_app/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const id = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubitCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
            ),
            child: const LoginViewBodyBlocConsumer(),
          ),
        ),
      ),
    );
  }
}

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubitCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginCubitLoading) {
          // isloading = true;
        }
        if (state is LoginCubitSuccess) {
          //to rebuild
          // BlocProvider.of<fetch>(context).Fetch();

          // Navigator.pop(context); //to pop the bottom sheet
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("success")));
          Navigator.pushNamed(context, ChatView.id);
        }
        if (state is LoginCubitFailure) {
          //show failure bar
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errmessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LoginCubitLoading ? true : false,
          child: const LoginViewBody(),
        );
      },
    );
  }
}
