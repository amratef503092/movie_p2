part of 'layout_admin_cubit.dart';

@immutable
abstract class LayoutAdminState {}

class LayoutAdminInitial extends LayoutAdminState {}
class LayoutAdminChangeIndex extends LayoutAdminState {}
class LayoutAdminLoading extends LayoutAdminState {}
class GetHallsSuccessful  extends LayoutAdminState {}
class GetHallsError  extends LayoutAdminState {}