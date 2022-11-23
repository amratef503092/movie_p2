import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/cinema_owner_model/halls_model.dart';

part 'get_halls_state.dart';

class GetHallsCubit extends Cubit<GetHallsState> {
  GetHallsCubit() : super(GetHallsInitial());
  static GetHallsCubit get(context) => BlocProvider.of(context);
  List<HallsModel> halls = [];
  Future<void> getHalls({required String cinemaID}) async {
    halls = [];
    emit(GetHallsLoading());
    await FirebaseFirestore.instance.collection('Halls').
    where('cinema_id',isEqualTo: cinemaID).get().then((value) {
      for (var element in value.docs) {
        print(element.id);
        halls.add(HallsModel.fromMap(element.data()));
      }
      emit(GetHallsSuccessful());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetHallsError());
    });
  }
}
