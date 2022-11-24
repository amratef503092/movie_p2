import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';
import 'package:time_range/time_range.dart';

import '../../../model/cinema_owner_model/cinema_model.dart';
import '../../../model/cinema_owner_model/halls_model.dart';
import '../../../view/pages/cinema_owner/MoviesScreen.dart';
import '../../../view/pages/cinema_owner/ProfileScreen.dart';
import '../../../view/pages/cinema_owner/TicketsScreen.dart';
import '../../../view/pages/cinema_owner/hells.dart';
import '../Get_halls/get_halls_cubit.dart';

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
    emit(LayoutCinemaChangeIndex());
  }
  TimeRangeResult? timeRangeResult;
  CinemaModel ? cinemaModel;
  Future<void> getCinemaInfo() async {
    emit(LayoutCinemaChangLoading());
    print(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(value['cinemaID'])
          .get()
          .then((value) {
        cinemaModel = CinemaModel.fromMap(value.data()!);

      });
      emit(GetCinemaInfoSuccessful());
    }).catchError((error) {
      print(error.toString());
      emit(GetCinemaInfoError());
    });
  }
  Future<void> editCinemaInfo({required String open , required String close}) async {
    emit(LayoutCinemaChangLoading());
    print(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('Cinemas')
          .doc(value['cinemaID'])
          .update({
        'close':close,
        'open':open,
      });
      getCinemaInfo();
      emit(EditCinemaOwnerInfoSuccessful());
    }).catchError((error) {
      print(error.toString());
      emit(EditCinemaOwnerInfoError());
    });
  }
}
