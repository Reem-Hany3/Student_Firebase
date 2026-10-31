part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
//==============  register part( sign up) ===========

class RegisterLoading extends AuthState{}
class RegisterSuccess extends AuthState{}
class RegisterFailure extends AuthState{
  final String msg;
  RegisterFailure(this.msg);

}



//=====================  login  part ==================

class LoginLoading extends AuthState{}
class LoginSuccess extends AuthState{}
class LoginFailure extends AuthState {
  final String msg;

  LoginFailure(this.msg);
}


//====================  email part  =====================
class EmailNotVerefied extends AuthState{}


class VerifyLoading extends AuthState{}
class VerifySuccess extends AuthState{}
class ResendVerifySuccess extends AuthState{}
class VerifyFailure extends AuthState{
  final String msg;
  VerifyFailure(this.msg);
}