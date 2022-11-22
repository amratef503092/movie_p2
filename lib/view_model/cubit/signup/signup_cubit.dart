import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_flutterr/model/user.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';

import '../../../model/cinema_owner_model/cinema_model.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(context) => BlocProvider.of(context);
  UserModel? user;

  Future<void> registerUser({
    required String email,
    required String password,
    required String gender,
    required String role,
    required String username,
    required String phone,
  }) async {
    // register function start
    emit(RegisterLoadingState());
    await FirebaseAuth
        .instance // firebase auth this library i use it to register i send request Email and password
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          print(phone);
      // if register successful i will add user data to firebase
      user = UserModel(
        ban: false,
        cinemaID: '',
        gender: gender,
        email: email,
        phone: phone,
        id: value.user!.uid,
        online: false,
        photo:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH6PjyUR8U-UgBWkOzFe38qcO29regN43tlGGk4sRd&s',
        role: role,
        name: username,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(user!.toMap())
          .then((value) async {
        emit(RegisterSuccessfulState());
      });
    }).catchError((onError) {
      if (onError is FirebaseAuthException) {
        print(onError.message);
        emit(RegisterErrorState(message: onError.message!));
      }
    }).catchError((e){
      print(e.toString());
    });
  }
  Cinemas ? cinemas;
  Future<void>createCinema({
  required String name,
  required String address,
  required String description,
  required int numberOfHalls,
  required int numberOfminiShops,
  required String open,
  required String close,
}) async
  {
    cinemas = Cinemas(id: '',
        name: name,
        address: address,
        description: description,
        number_of_halls: numberOfHalls,
        number_of_mini_shops: numberOfminiShops, open: open,
        close: close,);
    emit(CreateCinemasLoading());
    await FirebaseFirestore.instance.collection('Cinemas').add(cinemas!.toMap()).
    then((value)
        async{
      print(value.id);
      await FirebaseFirestore.instance.collection('Cinemas').
      doc(value.id).
      update({
        'id':value.id ,
      'cinemaOwnerID':FirebaseAuth.instance.currentUser!.uid,
      });
      await FirebaseFirestore.instance.collection('users').
      doc(FirebaseAuth.instance.currentUser!.uid).update({
        'cinemaID':value.id,
      });
      emit(CreateCinemasSuccessful());
    }).catchError((onError)
    {
      emit(CreateCinemasError());
    });
  }
}
