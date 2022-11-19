part of 'main_page_cubit.dart';

@immutable
abstract class MainPageState {}

class MainPageInitial extends MainPageState {}

class PageChanged extends MainPageState{}

class GetReleasedMoviesLoading extends MainPageState{}
class GetReleasedMoviesError extends MainPageState{}
class GetReleasedMoviesSuccess extends MainPageState{}

class GetUpComingMoviesLoading extends MainPageState{}
class GetUpComingMoviesError extends MainPageState{}
class GetUpComingMoviesSuccess extends MainPageState{}
