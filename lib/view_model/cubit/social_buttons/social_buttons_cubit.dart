import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'social_buttons_state.dart';

class SocialButtonsCubit extends Cubit<SocialButtonsState> {
  SocialButtonsCubit() : super(SocialButtonsInitial());

  static SocialButtonsCubit get(context) => BlocProvider.of(context);

  
  bool _twitterIconHover = false;
  bool _facebookIconHover = false;
  bool _googleIconHover = false;

  void showHover(int btnIndex, bool value) {
    switch (btnIndex) {
      case 0:
        _twitterIconHover = value;
        break;
      case 1:
        _facebookIconHover = value;
        break;
      case 2:
        _googleIconHover = value;
        break;
    }
    emit(IconHover());
  }

  bool isButtonHover(int btnIndex) {
    bool result = false;
    switch (btnIndex) {
      case 0:
        result = _twitterIconHover;
        break;
      case 1:
        result = _facebookIconHover;
        break;
      case 2:
        result = _googleIconHover;
        break;
    }
    return result;
  }
}
