part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
// login state start
class LoginLoadingState extends AuthState{
  LoginLoadingState();
}
class LoginSuccessfulState extends AuthState{
  String message;
  String role;
  bool ban;
  bool approved;
  LoginSuccessfulState({required this.message,required this.role , required this.ban,required this.approved});
}
class LoginErrorState extends AuthState{
  String message;
  LoginErrorState(this.message);
}
// login state end

// start Register state
class RegisterLoadingState extends AuthState{
  RegisterLoadingState();
}
class RegisterSuccessfulState extends AuthState{
  String message;
  RegisterSuccessfulState(this.message);
}
class RegisterErrorState extends AuthState{
  String message;
  RegisterErrorState(this.message);
}
// start Register state
// start Register state
class GetUserDataLoadingState extends AuthState{
  GetUserDataLoadingState();
}
class GetUserDataSuccessfulState extends AuthState{
  String message;
  GetUserDataSuccessfulState(this.message);
}
class GetUserDataErrorState extends AuthState{
  String message;
  GetUserDataErrorState(this.message);
}
// start Register state
// start Register state
class UpdateDataLoadingState extends AuthState{
  UpdateDataLoadingState();
}
class UpdateDataSuccessfulState extends AuthState{
  String message;
  UpdateDataSuccessfulState(this.message);
}
class UpdateDataErrorState extends AuthState{
  String message;
  UpdateDataErrorState(this.message);
}
// start Register state
//
class UploadImageStateSuccessful extends AuthState{
  String message;
  UploadImageStateSuccessful(this.message);
}
class UploadImageStateError extends AuthState{
  String message;
  UploadImageStateError(this.message);
}
class UploadImageStateLoading extends AuthState{
  String message;
  UploadImageStateLoading(this.message);
}
//end image state
// start get Admin
class GetAdminsStateSuccessful extends AuthState{
  String message;
  GetAdminsStateSuccessful(this.message);
}
class GetAdminsStateError extends AuthState{
  String message;
  GetAdminsStateError(this.message);
}
class GetAdminsStateLoading extends AuthState{
  String message;
  GetAdminsStateLoading(this.message);
}
// end admin
class SendMessageStateLoading extends AuthState{
  String message;
  SendMessageStateLoading(this.message);
}
class SendMessageStateError extends AuthState{
  String message;
  SendMessageStateError(this.message);
}
class SendMessageStateSuccessful extends AuthState{
  String message;
  SendMessageStateSuccessful(this.message);
}
// get pharmacy details
class GetPharmacyDetailsStateLoading extends AuthState{
  String message;
  GetPharmacyDetailsStateLoading(this.message);
}
class GetPharmacyDetailsStateError extends AuthState{
  String message;
  GetPharmacyDetailsStateError(this.message);
}
class GetPharmacyDetailsStateSuccessful extends AuthState{
  String message;
  GetPharmacyDetailsStateSuccessful(this.message);
}
class AddPharmacyDetailsStateLoading extends AuthState{
  String message;
  AddPharmacyDetailsStateLoading(this.message);
}
class AddPharmacyDetailsStateError extends AuthState{
  String message;
  AddPharmacyDetailsStateError(this.message);
}
class AddPharmacyDetailsStateSuccessful extends AuthState{
  String message;
  AddPharmacyDetailsStateSuccessful(this.message);
}
// create services start
class GetUrlSuccessfulState extends AuthState{
  String message;
  GetUrlSuccessfulState(this.message);
}
class GetAllCinemaOwnerLoadingState extends AuthState{
  GetAllCinemaOwnerLoadingState();
}
class GetAllCinemaOwnerSuccessfulState extends AuthState{
  String message;
  GetAllCinemaOwnerSuccessfulState(this.message);
}
class GetAllCinemaOwnerErrorState extends AuthState{
  String message;
  GetAllCinemaOwnerErrorState(this.message);
}
// delete service end

class GetAllCustomerScreenLoading extends AuthState{}
class GetAllCustomerScreenSuccessful extends AuthState{}
class GetAllCustomerScreenError extends AuthState{}
class GetHallsLoading extends AuthState {}
class GetHallsSuccessful  extends AuthState {}
class GetHallsError  extends AuthState {}
class CreateHallsLoading  extends AuthState {}
class CreateHallsSuccessful  extends AuthState {}
class CreateHallsError  extends AuthState {
  final String error;
  CreateHallsError(this.error);
}
class EditHallsLoading  extends AuthState {}
class EditHallsSuccessful  extends AuthState {}
class EditHallsError  extends AuthState {}
class PickImageSuccessful extends AuthState {}
class AddNewFilmLoading extends AuthState {}
class AddNewFilmSuccessful extends AuthState {}
class AddNewFilmError extends AuthState {}
class GetFilmsLoading extends AuthState {}
class GetFilmsSuccessful extends AuthState {}
class GetFilmsError extends AuthState {}
class DeleteFilmLoading extends AuthState {}
class DeleteFilmSuccessful extends AuthState {}
class DeleteFilmError extends AuthState {}
class EditFilmLoading extends AuthState {}
class EditFilmSuccessful extends AuthState {}
class EditFilmError extends AuthState {}
class GetHallInfoLoading extends AuthState {}
class GetHallInfoSuccessful extends AuthState {}
class GetHallInfoError extends AuthState {}

class CreateMainShopesLaoding extends AuthState {}
class CreateMainShopesSuccessful extends AuthState {}
class CreateMainShopesError extends AuthState {}
class GetMiniShopesLoading extends AuthState {}
class GetMiniShopesSuccessful extends AuthState {}
class GetMiniShopesError extends AuthState {}
class AddSnacksLoading extends AuthState {}
class AddSnacksSuccessful extends AuthState {}
class AddSnacksError extends AuthState {}
class GetSnacksLoading extends AuthState {}
class GetSnacksSuccessful extends AuthState {}
class GetSnacksError extends AuthState {}
class DeleteSnackLoading extends AuthState {}
class EditSnacksLoading extends AuthState {}
class EditSnacksSuccessful extends AuthState {}
class EditSnacksError extends AuthState {}


