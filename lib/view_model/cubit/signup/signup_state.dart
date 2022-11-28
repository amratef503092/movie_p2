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
class CreateCinemasLoading extends SignupState{

}
class CreateCinemasError extends SignupState{

}
class CreateCinemasSuccessful extends SignupState{

}
class PhoneISNotUnique extends SignupState{}