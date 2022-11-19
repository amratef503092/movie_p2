import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'text_field_state.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(TextFieldInitial());

  static TextFieldCubit get(context) => BlocProvider.of(context);

  bool visable = false;

  void changeVisablityState(){
    visable = !visable;
    emit(visable ? PasswordShown() : PasswordHidden());
  }
}
