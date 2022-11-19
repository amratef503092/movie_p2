part of 'ticket_booking_cubit.dart';

@immutable
abstract class TicketBookingState {}

class TicketBookingInitial extends TicketBookingState {}

class PageChanged extends TicketBookingState{}

class SelectSeat extends TicketBookingState {}
