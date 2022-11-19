import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_flutterr/model/user.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  // login function use it to login in app i reseved email and password to login
  UserModel ? userModel;
  Future<void> login({required String email, required String password}) async {
    emit(UserLoginLoading());
    userModel = null; // here i remove all old data to receive New Data
    await FirebaseAuth
        .instance // firebase auth this library i use it to login i send request Email and password
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // if login successful i will update user is online to true
    await  FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .update({'online': true});
      await CacheHelper.put(
          key: 'id', value: value.user!.uid); // i cache user id to use
      // if login successful i will get user id and i will use it to get user data from firebase
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .get()
          .then((value) async {
        // here i will store user data in userModel
        userModel = UserModel.fromMap(value.data()!);
        await CacheHelper.put(
            key: 'role', value: userModel!.role); //  cashing role user
        emit(UserLoginSuccess(
            role: value['role'],
            message: 'login success',
            ban: value['ban'],));
      });
    }).catchError((onError) {
      // if email Error or password Error show message :D
      if (onError is FirebaseAuthException) {
        emit(UserLoginFailed());
      }
    });
  }
}
