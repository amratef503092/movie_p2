part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UserLoginLoading extends LoginState {}

class UserLoginSuccess extends LoginState {
  String role;
  String message;
  String userID;
  bool ban;

  String cinemaID;

  UserLoginSuccess(
      {required this.userID,
      required this.role,
      required this.message,
      required this.ban,
      required this.cinemaID});
}

class UserLoginFailed extends LoginState {
  String message;
  UserLoginFailed({required this.message});
}
