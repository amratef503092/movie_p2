import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../view/pages/cinema_owner/MoviesScreen.dart';
import '../../../view/pages/cinema_owner/ProfileScreen.dart';
import '../../../view/pages/cinema_owner/TicketsScreen.dart';
import '../../../view/pages/cinema_owner/hells.dart';

part 'layout_cinema_owner_state.dart';

class LayoutCinemaOwnerCubit extends Cubit<LayoutCinemaOwnerState> {
  LayoutCinemaOwnerCubit() : super(LayoutCinemaOwnerInitial());
  static LayoutCinemaOwnerCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const HallsScreen(),
    const MoviesScreen(),
    const TicketsScreen(),
    const ProfileScreen(),
  ];

    void changeIndex(int index) {
      currentIndex = index;
      emit(LayoutCinemanChangeIndex());
    }

}
