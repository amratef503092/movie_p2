import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_flutterr/view/pages/admin/home_admin_screen.dart';

import '../../../view/pages/admin/cinema_owner_screen.dart';
import '../../../view/pages/admin/customer_screen_admin.dart';

part 'layout_admin_state.dart';

class LayoutAdminCubit extends Cubit<LayoutAdminState> {
  LayoutAdminCubit() : super(LayoutAdminInitial());

  static LayoutAdminCubit get(context) =>
      BlocProvider.of<LayoutAdminCubit>(context);
  List<Widget> screens = [
    const HomeAdminScreen(),
    const CinemaOwnerAdmin(),
    const CustomerScreenAdmin()
  ];
  List<String> appbarTitle = ["Admin", "pharmacy", "Customer"];
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(LayoutAdminChangeIndex());
  }

}
