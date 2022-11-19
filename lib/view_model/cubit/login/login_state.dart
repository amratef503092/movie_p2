part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UserLoginLoading extends LoginState{}

class UserLoginSuccess extends LoginState{
  String role;
  String message;
  bool ban;

  UserLoginSuccess({ required this.role,required this.message,required this.ban});
}

class UserLoginFailed extends LoginState{}