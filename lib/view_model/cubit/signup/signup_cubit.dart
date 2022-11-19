import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/user.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';
import 'package:movie_flutterr/view_model/database/network/dio_helper.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);

  Future<dynamic> registerUser(json, String endpoint, context) async {
    DioHelper.dio
        .post(
      endpoint,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(json),
    )
        .then((value) {
      if (value.statusCode == 200) {
        print("success");
        TOKEN = value.data['accessToken'];
        user = User(
            id: value.data["user"]["id"],
            email: value.data["user"]["email"],
            name: value.data["user"]["name"]);
        print('Token : $TOKEN');
        emit(UserSigendUpSuccess());
        //CacheHelper.put(value: true,key: LOGIN_CHECK_KEY);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (route) => false);
      } else {
        print("Error");
      }
    });
  }
}
