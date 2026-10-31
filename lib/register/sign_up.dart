// import 'package:first_proj/Screen_Home/Home.dart';
// import 'package:first_proj/home_navigation/home_nav.dart';
import 'package:firebase/auth_cubit/auth_cubit.dart';
import 'package:firebase/login/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/helpers/custom_app_button.dart';
import '../core/helpers/custom_app_field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sign up",
          style: TextStyle(
            fontWeight: FontWeight(500),
            color: Color(0xffFF5E00),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios, color: Color(0xffFF5E00)),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          //------------- Success ------------

          if (state is RegisterSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Sign up Success'),
              ),
            );
            //========== navigate to login screen
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn(),));
          }

          //------------- Failure ------------

          if (state is RegisterFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red, content: Text(state.msg)),
            );}
        },
        builder: (context, state) {
          // ----------------------   Store Loading State  -----------

          final loadingstate = state is RegisterLoading;

          final cubit = BlocProvider.of<AuthCubit>(context);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32),
                  Image.asset('assets/images/signUP.png', height: 272),
                  SizedBox(height: 64),
                  Text(
                    ' Please enter your information to\ncreate an account.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xff6D3805),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  CustomAppField(
                    controller: cubit.emailRegisterControl,
                    hint: 'Email',
                  ),
                  SizedBox(height: 8),
                  CustomAppField(
                    controller: cubit.passwordRegisterControl,
                    hint: 'Password',
                    SuffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: Color(0xffFF5E00),
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomAppField(
                    controller: cubit.passwordRegisterControl,
                    hint: 'Confirm Password',
                    SuffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      color: Color(0xffFF5E00),
                    ),
                  ),
                  SizedBox(height: 72),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(60),
                      backgroundColor: Color(0xffFF5E00),
                    ),
                    onPressed: () {
                      cubit.signup();
                    },
                    child:
                        loadingstate?Center(child: CircularProgressIndicator(color:Colors.white,),):
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
