import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'ticket_booking_state.dart';

class TicketBookingCubit extends Cubit<TicketBookingState> {
  TicketBookingCubit() : super(TicketBookingInitial());

  static TicketBookingCubit get(context) => BlocProvider.of(context);

  double barDividerNumber = 2;
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);
  Function backButtonFunction = (context) {};
  String movieTime = "";
  int totalPrice = 0;

  List<String> seats = [];

  void instialize(context) {
    backButtonFunction = (context) {
      switch (currentPage) {
        case 0:
          Navigator.pop(context);
          break;
        case 1:
          changePage(-1);
          break;
        case 2:
          changePage(-1);
          break;
      }
    };
  }

  void changePage(int direction) {
    currentPage += direction;
    pageController.animateToPage(currentPage,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
    barDividerNumber -= direction * 0.6;
    emit(PageChanged());
  }

  void selectSeat(String seate) {
    if (seats.contains(seate)) {
      seats.remove(seate);
      totalPrice -= 50;
    } else {
      seats.add(seate);
      totalPrice += 50;
    }
    emit(SelectSeat());
  }
}
