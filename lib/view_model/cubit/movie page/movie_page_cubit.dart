import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'movie_page_state.dart';

class MoviePageCubit extends Cubit<MoviePageState> {
  MoviePageCubit() : super(MoviePageInitial());

  static MoviePageCubit get(context) => BlocProvider.of(context);

  DateTime? selectedDate;
  int selectedIndex = 1;

  void initialize(){
    selectedDate = DateTime.now();
  }

  void changeDate(DateTime newDate , int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    selectedDate = newDate;
    emit(DateChanged());
  }
}
