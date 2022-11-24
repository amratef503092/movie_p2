import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:time_range/time_range.dart';

import '../../../model/cinema_owner_model/cinema_model.dart';
import '../../../model/cinema_owner_model/halls_model.dart';

part 'get_halls_state.dart';

class GetHallsCubit extends Cubit<GetHallsState> {
  GetHallsCubit() : super(GetHallsInitial());
  static GetHallsCubit get(context) => BlocProvider.of(context);


}
