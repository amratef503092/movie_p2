import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  String _searchText = "";

  void searchTextChanged(String value) {
    _searchText = value;
    emit(SearchTextChanged());
  }

  bool showMovieInList(String name) {
    return name.toLowerCase().contains(_searchText.toLowerCase());
  }
}
