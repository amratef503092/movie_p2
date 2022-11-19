part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class UserSigendUpSuccess extends SignupState {}

class UserSigendUpFailed extends SignupState {}