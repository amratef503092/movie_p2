part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class RegisterLoadingState extends SignupState {}

class RegisterSuccessfulState extends SignupState {

}
class RegisterErrorState extends SignupState {
  String message;
  RegisterErrorState({required this.message});
}