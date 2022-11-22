part of 'layout_cinema_owner_cubit.dart';

@immutable
abstract class LayoutCinemaOwnerState {}

class LayoutCinemaOwnerInitial extends LayoutCinemaOwnerState {}
class LayoutCinemaChangeIndex extends LayoutCinemaOwnerState {}
class LayoutCinemaChangLoading extends LayoutCinemaOwnerState {}
class LayoutCinemaChangSuccessful extends LayoutCinemaOwnerState {}
class LayoutCinemaChangError extends LayoutCinemaOwnerState {}
