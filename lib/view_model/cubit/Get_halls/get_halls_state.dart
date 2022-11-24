part of 'get_halls_cubit.dart';

@immutable
abstract class GetHallsState {}

class GetHallsInitial extends GetHallsState {}
class GetHallsLoading extends GetHallsState {}
class GetHallsSuccessful  extends GetHallsState {}
class GetHallsError  extends GetHallsState {}
class CreateHallsLoading  extends GetHallsState {}
class CreateHallsSuccessful  extends GetHallsState {}
class CreateHallsError  extends GetHallsState {
  final String error;
  CreateHallsError(this.error);
}