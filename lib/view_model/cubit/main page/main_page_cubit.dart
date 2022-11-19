import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/released_movie.dart';
import 'package:movie_flutterr/model/movies/upcoming_movie.dart';
import 'package:movie_flutterr/view_model/database/network/dio_helper.dart';
import 'package:movie_flutterr/view_model/database/network/end_points.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageInitial());

  static MainPageCubit get(context) => BlocProvider.of(context);

  int currentPageIndex = 0;
  bool pageChangesFromNav = false;

  PageController pageController = PageController(initialPage: 0);

  List<ReleasedMovie> releasedMovies = [];
  List<UpComingMovie> upComingMovies = [];

  void swipePage(int index) {
    if (index == currentPageIndex || pageChangesFromNav) return;

    currentPageIndex = index;

    emit(PageChanged());
  }

  void changePage(int index) {
    if (index == currentPageIndex) return;

    pageChangesFromNav = true;
    currentPageIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.fastLinearToSlowEaseIn).then((value) => pageChangesFromNav = false);

    emit(PageChanged());
  }

  Future<dynamic> getReleasedMoviesData() async {
    emit(GetReleasedMoviesLoading());

    DioHelper.dio
        .get(
      MOVIES_ENDPOINT,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $TOKEN'
      }),
    )
        .then((value) {
      if (value.statusCode == 200) {
        print("Released Movies Success");
        for (int i = 0; i < value.data.length; i++) {
          releasedMovies.add(ReleasedMovie.fromJson(value.data[i]));
        }
        emit(GetReleasedMoviesSuccess());
      } else {
        print("Released Movies Failed");

        emit(GetReleasedMoviesError());
      }
    });
  }

  Future<dynamic> getUpComingMoviesData() async {
    emit(GetUpComingMoviesLoading());

    DioHelper.dio
        .get(
      MOVIES_ENDPOINT + UPCOMING_ENDPOINT,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer $TOKEN'
      }),
    )
        .then((value) {
      if (value.statusCode == 200) {
        print("UpComing Movies Success");
        for (int i = 0; i < value.data.length; i++) {
          upComingMovies.add(UpComingMovie.fromJson(value.data[i]));
        }
        emit(GetUpComingMoviesSuccess());
      } else {
        print("UpComing Movies Failed");

        emit(GetUpComingMoviesError());
      }
    });
  }
}
