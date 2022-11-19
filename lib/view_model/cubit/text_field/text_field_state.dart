part of 'text_field_cubit.dart';

@immutable
abstract class TextFieldState {}

class TextFieldInitial extends TextFieldState {}

class PasswordHidden extends TextFieldState{}

class PasswordShown extends TextFieldState{}
