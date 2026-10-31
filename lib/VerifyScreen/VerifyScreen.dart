import 'package:firebase/auth_cubit/auth_cubit.dart';
import 'package:firebase/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/Home_View.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Your Email')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          ///---------------------Verify Success ------------------
          if (state is VerifySuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          }

          /// -------------------Resend Success  --------------------------
          if (state is ResendVerifySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Code Is Send Success Please Check Your Mail'),
              ),
            );
          }


          ///-------------------- Verificatin Failure   --------------------
             if (state is VerifyFailure){
               ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     backgroundColor:Colors.red,
                     content: Text(state.msg,) ,

                   ),);

             }
        },
        builder: (context, state) {
          final isLoading =state is VerifyLoading;
          final cubit =BlocProvider.of<AuthCubit>(context);

          return Column(
            children: [
              Text('Verify Your Email Address'),
              ElevatedButton(
                onPressed: () {
                  cubit.resendMailVerification();
                },
                child:
                isLoading?Center(child: CircularProgressIndicator(color: Colors.white,))
                :Text('Send Email Verify'),
              ),
            ],
          );
        },
      ),
    );
  }
}
