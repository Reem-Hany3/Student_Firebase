//import 'package:first_proj/Screen_sign_up/sign_up.dart';
//import 'package:first_proj/home_navigation/home_nav.dart';
import 'package:firebase/Home/Home_View.dart';
import 'package:firebase/VerifyScreen/VerifyScreen.dart';
import 'package:firebase/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../VerifyScreen/VerifyScreen.dart';

import '../register/sign_up.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sign in",
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
            child: Icon(Icons.arrow_back_ios, color: Color(0xffFF5E00))),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(


        listener: (context, state) {
          //------------- Success ------------

          if (state is LoginSuccess)
          {  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text('Login Success'),
              ),
            );
            //========== navigate to home screen
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeView(),));
          }

          //------------- Failure ------------

          if (state is LoginFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red, content: Text(state.msg)),
            );}
          
          
          //---------------------- Email not verified ----------
          if(state is EmailNotVerefied){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(backgroundColor: Colors.orange,
                  content: Text('Your Email is Not Verified yet Please Verify your email !'),));
Duration(seconds: 3);
            Navigator.of(context).push
              (MaterialPageRoute(builder:
                (_) =>
                    BlocProvider.value(
  value: context.read<AuthCubit>() ,
  child: VerifyScreen(),
) ,));
          }
        },
        builder: (context, state) {

          final loadingstate = state is LoginLoading;

          final cubit = BlocProvider.of<AuthCubit>(context);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32),
                  Image.asset('assets/images/signin.png', height: 272),
                  SizedBox(height: 64),
                  Text(
                    'Enter your Email and\npassword to access your account',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xff6D3805),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 60),
                  SizedBox(
                    height: 64,
                    child: TextFormField(
                      controller: cubit.emailLoginControl,
                      decoration: InputDecoration(
                        hintText: "Email",
                        filled: true,
                        fillColor: Color(0xffF3F3F3),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffFF5E00)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 64,
                    child: TextFormField(
                      controller: cubit.passwordLoginControl,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: Icon(
                          Icons.visibility_outlined,
                          color: Color(0xffFF5E00),
                        ),
                        filled: true,
                        fillColor: Color(0xffF3F3F3),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffFF5E00)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight(500),
                        color: Color(0xffFF5E00),
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(height: 96),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(55),
                      backgroundColor: Color(0xffFF5E00),
                    ),
                    onPressed: () { cubit.Login(); },
                    child:
                        loadingstate?Center(child: CircularProgressIndicator(color:Colors.white,),):
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff7F4E1D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                         onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));},
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffFF5E00),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
