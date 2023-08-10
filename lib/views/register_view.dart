
import 'package:chat_app/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'cubits/register_cubit/register_cubit.dart';



class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const id = 'register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover),
            ),
            child: RegisterBlocConsumerVeiwBody(),
          ),
        ),
      ),
    );
  }
}

class RegisterBlocConsumerVeiwBody extends StatelessWidget {
  const RegisterBlocConsumerVeiwBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          // isloading = true;
        }
        if (state is RegisterSuccess) {
          //to rebuild
          // BlocProvider.of<fetch>(context).Fetch();

          Navigator.pop(context); //to pop the bottom sheet
        }
        if (state is RegisterFailure) {
          //show failure bar
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errmessage)));
        }
      },
      builder: (context, state) {
        return  ModalProgressHUD(
          inAsyncCall: state is RegisterLoading? true : false,
          child: const RegisterViewBody(
        
          ),
        );
      },
    );
  }
}
