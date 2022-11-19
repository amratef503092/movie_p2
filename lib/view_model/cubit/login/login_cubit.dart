import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_flutterr/model/user.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';

import '../../../constants/constants.dart';
import '../../database/network/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<dynamic> loginUser(json, String endpoint, context) async {
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
        TOKEN = value.data['accessToken'];
        user = User(
            id: value.data["user"]["id"],
            email: value.data["user"]["email"],
            name: value.data["user"]["name"]);
        print("success\n Token : $TOKEN");
        emit(UserLoginSuccess());
        //CacheHelper.put(value: true,key: LOGIN_CHECK_KEY);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (route) => false);
      } else {
        emit(UserLoginFailed());
        print("Error");
      }
    });
  }
}
