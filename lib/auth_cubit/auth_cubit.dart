import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  /// =======   Instance from firebase
  final fireAuth = FirebaseAuth.instance;

  ///---------------    Controllers    -------------
  TextEditingController emailRegisterControl = TextEditingController();
  TextEditingController passwordRegisterControl = TextEditingController();
  TextEditingController emailLoginControl = TextEditingController();
  TextEditingController passwordLoginControl = TextEditingController();

  ///==============================================  Sign Up   ==========================================

  Future<void> signup() async {
    emit(RegisterLoading());
    try {
      // --------------  Response   ------------------
      final data = await fireAuth.createUserWithEmailAndPassword(
        email: emailRegisterControl.text,
        password: passwordRegisterControl.text,
      );

      // -------------------    check   -------------
      if (data.user == null) {
        emit(RegisterFailure('Unable To Create An Account !'));
        return;
      }

      // -------------   Call Method To Send Verification  --------------

      await data.user!.sendEmailVerification();

      emit(RegisterSuccess());
    }
    //// ============   Handle Error    ===============
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('The account already exists for that email.'));
      } else {
        emit(RegisterFailure('FireAuth Exception'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  ///==============================================  Login   ==========================================

  Future<void> Login() async {
    emit(LoginLoading());
    try {
      //============== Request  ==========

      final data = await fireAuth.signInWithEmailAndPassword(
        email: emailLoginControl.text,
        password: passwordLoginControl.text,
      );

      // -----------  check if there is a user  ---------
      if (data.user == null) {
        emit(LoginFailure('Unable To Login'));
        return;
      }

      // --------------  refresh   ----------
      await data.user!.reload();

      //-----------  get  user  from   server   ----------
      final updateduser = fireAuth.currentUser;

      // ----------------  check if there  is  an  user    and email is verified
      if (updateduser != null && updateduser.emailVerified) {
        emit(LoginSuccess());
      } else {
        emit(EmailNotVerefied());
      }
    }
    //================   Handle Errors  ===================
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure('password or mail is incorrect'));
      } else {
        emit(LoginFailure('FireAuth Exception'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  ///========================================= Resend Mail Verification  ================

  Future<void> resendMailVerification() async {
    emit(VerifyLoading());
    try {
      final user = fireAuth.currentUser;
      if (user == null) {
        emit(VerifyFailure('Please Sign in to continue '));
        return;
      }

      await user.reload();
      final updatedUser = fireAuth.currentUser;
      if (updatedUser == null) {
        emit(VerifyFailure('No Login Data Found'));
        return;
      }
      if (updatedUser.emailVerified) {
        emit(VerifySuccess());
        return;
      }

      ///----------------------  send mail verification  --------
      await updatedUser.sendEmailVerification();
      emit(ResendVerifySuccess());
    }
    ///------------------ Handle errors-----------------
    on FirebaseAuthException catch (e) {
      emit(VerifyFailure(e.code));
    } catch (e) {
      emit(VerifyFailure(e.toString()));
    }
  }
}
