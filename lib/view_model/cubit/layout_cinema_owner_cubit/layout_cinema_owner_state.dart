part of 'layout_cinema_owner_cubit.dart';

@immutable
abstract class LayoutCinemaOwnerState {}

class LayoutCinemaOwnerInitial extends LayoutCinemaOwnerState {}
class LayoutCinemaChangeIndex extends LayoutCinemaOwnerState {}
class LayoutCinemaChangLoading extends LayoutCinemaOwnerState {}
class LayoutCinemaChangSuccessful extends LayoutCinemaOwnerState {}
class LayoutCinemaChangError extends LayoutCinemaOwnerState {}
class GetCinemaInfoSuccessful extends LayoutCinemaOwnerState {}
class GetCinemaInfoError extends LayoutCinemaOwnerState {}
class GetCinemaOwnerInfoSuccessful extends LayoutCinemaOwnerState {}
class GetCinemaOwnerInfoError extends LayoutCinemaOwnerState {}
class EditCinemaOwnerInfoSuccessful extends LayoutCinemaOwnerState {}
class EditCinemaOwnerInfoError extends LayoutCinemaOwnerState {}
class CreateHallsLoading extends LayoutCinemaOwnerState {}
class CreateHallsSuccessful extends LayoutCinemaOwnerState {}
class CreateHallsError extends LayoutCinemaOwnerState {
  final String error;
  CreateHallsError(this.error);
}


