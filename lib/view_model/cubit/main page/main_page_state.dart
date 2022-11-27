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

class GetHallInfoLoading extends MainPageState{}
class GetHallInfoError extends MainPageState{}
class GetHallInfoSuccess extends MainPageState{}
class GetSnacksLoading extends MainPageState{}
class GetSnacksError extends MainPageState{}
class GetSnacksSuccess extends MainPageState{}
class BookTicketLoading extends MainPageState{}
class BookTicketError extends MainPageState{}
class BookTicketSuccess extends MainPageState{
  final String ticketId;
  BookTicketSuccess({required this.ticketId});
}
class BuySnacksLoading extends MainPageState{}
class BuySnacksError extends MainPageState{}
class BuySnacksSuccess extends MainPageState{}
class GetMySnacksLoading extends MainPageState{}
class GetMySnacksError extends MainPageState{}
class GetMySnacksSuccess extends MainPageState{}
class GetMyTicketsLoading extends MainPageState{}
class GetMyTicketsError extends MainPageState{}
class GetMyTicketsSuccess extends MainPageState{}
class DeleteSnackSuccess extends MainPageState{}
class DeleteSnackError extends MainPageState{}
class DeleteSnackLoading extends MainPageState{}
class GetMovieInfoLoading extends MainPageState{}
class GetMovieInfoError extends MainPageState{}
class GetMovieInfoSuccess extends MainPageState{}
class DeleteMovieTicketsLoading extends MainPageState{}
class DeleteMovieTicketsError extends MainPageState{}
class DeleteMovieTicketsSuccess extends MainPageState{}
class EditTicketLoading extends MainPageState{}
class EditTicketError extends MainPageState{}
class EditTicketSuccess extends MainPageState{}
class GetUsersLoading extends MainPageState{}
class GetUsersError extends MainPageState{}
class GetUsersSuccess extends MainPageState{}
class GetUserInfoLoading extends MainPageState{}
class GetUserInfoSuccess extends MainPageState{}
class GetUserInfoError extends MainPageState{}
class CancelOrderLoading extends MainPageState{}
class CancelOrderError extends MainPageState{}
class CancelOrderSuccess extends MainPageState{}
class AcceptedOrderLoading extends MainPageState{}
class AcceptedOrderError extends MainPageState{}
class AcceptedOrderSuccess extends MainPageState{}
class GetCinemaInfo extends MainPageState{}
class GetCinemaInfoLoading extends MainPageState{}
class GetCinemaInfoError extends MainPageState{}

