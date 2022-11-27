import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/cinema_owner_model/halls_model.dart';
import 'package:movie_flutterr/model/cinema_owner_model/movie_model.dart';
import 'package:movie_flutterr/model/cinema_owner_model/snacks.dart';
import 'package:movie_flutterr/model/movies/released_movie.dart';
import 'package:movie_flutterr/model/movies/upcoming_movie.dart';
import 'package:movie_flutterr/model/user_model/get_my_snacks..dart';
import 'package:movie_flutterr/view_model/database/network/dio_helper.dart';
import 'package:movie_flutterr/view_model/database/network/end_points.dart';

import '../../../model/cinema_owner_model/cinema_model.dart';
import '../../../model/user.dart';
import '../../../model/user_model/getMyTickets.dart';

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
    pageController
        .animateToPage(index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn)
        .then((value) => pageChangesFromNav = false);

    emit(PageChanged());
  }

  List<MovieModel> movies = [];

  Future<dynamic> getReleasedMoviesData() async {
    movies = [];
    emit(GetReleasedMoviesLoading());
    await FirebaseFirestore.instance.collection('Movie').get().then((value) {
      value.docs.forEach((element) {
        movies.add(MovieModel.fromMap(element.data()));
      });
      emit(GetReleasedMoviesSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetReleasedMoviesError());
    });
  }

  HallsModel? hallsModel;

  Future<void> getHellInfo({required String hallName}) async {
    emit(GetHallInfoLoading());
    await FirebaseFirestore.instance
        .collection('Halls')
        .doc(hallName)
        .get()
        .then((value) {
      print(value.data());
      hallsModel = HallsModel.fromMap(value.data()!);
      emit(GetHallInfoSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetHallInfoError());
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

  List<SnacksModel> snacksModel = [];

  Future<void> getSnacks({required String cinemaID}) async {
    snacksModel = [];
    emit(GetSnacksLoading());
    await FirebaseFirestore.instance
        .collection('Snacks')
        .where('cinemaId', isEqualTo: cinemaID)
        .get()
        .then((value) {
      for (var element in value.docs) {
        snacksModel.add(SnacksModel.fromMap(element.data()));
      }
      emit(GetSnacksSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetSnacksError());
    });
  }

  Future<void> bookTicket({
    required String movieName,
    required String hallName,
    required String time,
    required String date,
    required int quantity,
    required int totalPrice,
    required String cinemaId,
    required int price,
    required String movieId,
    required String userId,
  }) async {
    emit(BookTicketLoading());
    TicketsModel ticketsModel = TicketsModel(
        orderStatus: 'Pending',
        cinemaId: cinemaId,
        date: date,
        hallName: hallName,
        movieID: movieId,
        movieName: movieName,
        price: price,
        quantity: quantity,
        ticketId: '',
        time: time,
        totalPrice: totalPrice,
        userID: userID);
    await FirebaseFirestore.instance
        .collection('Tickets')
        .add(ticketsModel.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(value.id)
          .update({
        'ticketId': value.id,
      });
      emit(BookTicketSuccess(ticketId: value.id));
    }).catchError((error) {
      print(error.toString());
      emit(BookTicketError());
    });
  }

  Future<void> buySnacks(
      {required String ticketID,
      required int totalPrice,
      required List<SnacksModel> snacksModel}) async {
    emit(BuySnacksLoading());
    print(ticketID);
    for (var element in snacksModel) {
      print(element.id);
      SnacksModel snacksModel = element;
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(ticketID)
          .collection('Snacks')
          .doc(element.id)
          .set({
        'UserID': FirebaseAuth.instance.currentUser!.uid,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('Tickets')
            .doc(ticketID)
            .collection('Snacks')
            .doc(element.id)
            .update(element.toMap());
      }).then((value) {
        emit(BuySnacksSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(BuySnacksError());
      });
    }
  }

  List<GetMySnacks> getMySnacksList = [];

  Future<void> getMySnacks({required String ticketId}) async {
    getMySnacksList = [];
    emit(GetMySnacksLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticketId)
        .collection('Snacks')
        .get()
        .then((value) {
      for (var element in value.docs) {
        getMySnacksList.add(GetMySnacks.fromMap(element.data()));
      }
      emit(GetMySnacksSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetMySnacksError());
    });
  }

  List<TicketsModel> tiketUser = [];
  List<CinemaModel> cinema = [];

  Future<void> getMyTicket() async {
    tiketUser = [];
    emit(GetMyTicketsLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        tiketUser.add(TicketsModel.fromMap(element.data()));

        // await FirebaseFirestore.instance
        //     .collection('Cinemas')
        //     .doc(element.data()['cinemaId'])
        //     .get()
        //     .then((value) {
        //   cinema.add(CinemaModel.fromMap(value.data()!));
        // });
      }
      print(tiketUser[0].movieName);
      emit(GetMyTicketsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetMyTicketsError());
    });
  }

  Future<void> deleteSnack(
      {required index2,
      required String tiketID,
      required String snackID}) async {
    print(tiketID);
    print(snackID);
    print(index2);

    emit(DeleteSnackLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(tiketID)
        .collection('Snacks')
        .doc(snackID)
        .delete()
        .then((value) {
      getMySnacksList.removeAt(index2);
      emit(DeleteSnackSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteSnackError());
    });
  }

  Future<void> editSnacks(
      {required index2,
      required String tiketID,
      required String snackID}) async {
    emit(DeleteSnackLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(tiketID)
        .collection('Snacks')
        .doc(snackID)
        .update(getMySnacksList[index2].toMap())
        .then((value) {
      getMySnacks(ticketId: tiketID);
      emit(DeleteSnackSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteSnackError());
    });
  }

  String getTotalPrice() {
    int totalPrice = 0;
    for (var element in getMySnacksList) {
      totalPrice = totalPrice + element.totalPrice;
    }
    return totalPrice.toString();
  }

  MovieModel? movieInfo;

  Future<void> getMovieInfo({required String movieID}) async {
    emit(GetMovieInfoLoading());
    await FirebaseFirestore.instance
        .collection('Movie')
        .doc(movieID)
        .get()
        .then((value) {
      movieInfo = MovieModel.fromMap(value.data()!);
      emit(GetMovieInfoSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetMovieInfoError());
    });
  }

  Future<void> deleteMovieTickets({required String ticketID}) async {
    emit(DeleteMovieTicketsLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticketID)
        .collection('Snacks')
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('Tickets')
            .doc(ticketID)
            .collection('Snacks')
            .doc(element.id)
            .delete();
      });
    });
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticketID)
        .delete()
        .then((value) {
      emit(DeleteMovieTicketsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteMovieTicketsError());
    });
  }

  Future<void> editTicket({
    required String date,
    required int quantity,
    required String ticketID,
    required int totalPrice,
  }) async {
    emit(EditTicketLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticketID)
        .update({
      'date': date,
      'quantity': quantity,
      'totalPrice': totalPrice,
    }).then((value) {
      emit(EditTicketSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(EditTicketError());
    });
  }

  List<UserModel> users = [];

  Future<void> getUsers() async {
    users = [];
    emit(GetUsersLoading());
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: '3')
        .get()
        .then((value) {
      for (var element in value.docs) {
        users.add(UserModel.fromMap(element.data()));
      }
      emit(GetUsersSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetUsersError());
    });
  }
  //
  CinemaModel ? cinemaInfo ;
  Future<void> getCineamInfo({required String cinemaID}) async {
    emit(GetCinemaInfoLoading());
    await FirebaseFirestore.instance
        .collection('Cinemas')
        .doc(cinemaID)
        .get()
        .then((value) async {
      cinemaInfo = CinemaModel.fromMap(value.data()!);
      emit(GetCinemaInfo());
    }).catchError((error) {
      print(error.toString());
      emit(GetCinemaInfoError());
    });
  }
  Future<void> getTicketCineam({required String cinemaID}) async {
    tiketUser = [];
    emit(GetMyTicketsLoading());
    await FirebaseFirestore.instance
        .collection('Tickets')
        .where('cinemaId', isEqualTo: cinemaID)
        .get()
        .then((value) async {
      for (var element in value.docs) {
        await FirebaseFirestore.instance
            .collection('Cinemas')
            .doc(element.data()['cinemaId'])
            .get()
            .then((value) {
          cinema.add(CinemaModel.fromMap(value.data()!));
        });
        print(element.data());
        tiketUser.add(TicketsModel.fromMap(element.data()));
      }
      emit(GetMyTicketsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetMyTicketsError());
    });
  }
  UserModel ?  user;
  Future<void> getUserInfoData({required String userID}) async
  {
    emit(GetUserInfoLoading());
    user = null;
    FirebaseFirestore.instance.collection('users').doc(userID).get().then((value) {
      print(value.data());
      user = UserModel.fromMap(value.data()!);
      emit(GetUserInfoSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetUserInfoError());
    });
  }
  Future<void> cancelOrder(String tiketID) async{
    emit(CancelOrderLoading());
    await await FirebaseFirestore.instance.collection('Tickets').doc(tiketID)
        .update({
      'orderStatus': 'rejected',
    }).then((value) {
      emit(CancelOrderSuccess());
    }).catchError((error){
      print(error.toString());
      emit(CancelOrderError());
    });
  }
  Future<void> accepted(String tiketID) async{
    emit(AcceptedOrderLoading());
    await FirebaseFirestore.instance.collection('Tickets').doc(tiketID)
        .update({
      'orderStatus': 'accepted',
    }).then((value) {
      emit(AcceptedOrderSuccess());
    }).catchError((error){
      print(error.toString());
      emit(AcceptedOrderError());
    });
  }

}
