import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/view_model/cubit/text_field/text_field_cubit.dart';

import '../../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.borderRadius,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      this.onChange})
      : super(key: key);

  TextEditingController controller;
  String hintText;
  bool isPassword;
  FocusNode focusNode = FocusNode();
  double borderRadius;
  Function? onChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextFieldCubit(),
      child: BlocBuilder<TextFieldCubit, TextFieldState>(
        builder: (context, state) {
          TextFieldCubit myCubit = TextFieldCubit.get(context);
          return Center(
            child: SizedBox(
              width: 280.w,
              height: 50,
              child: TextField(
                onChanged: (value) {
                  if (onChange != null) onChange!(value);
                },
                focusNode: focusNode,
                obscureText: isPassword && !myCubit.visable,
                cursorColor: RED_COLOR,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
                textAlignVertical: TextAlignVertical.bottom,
                controller: controller,
                decoration: InputDecoration(
                  fillColor: TEXT_FIELD_BACKGROUND_COLOR,
                  filled: true,
                  focusedBorder: focusBorder(),
                  enabledBorder: normalBorder(),
                  border: normalBorder(),
                  suffixIcon: isPassword
                      ? GestureDetector(
                          onTap: () {
                            myCubit.changeVisablityState();
                          },
                          child: Icon(
                            myCubit.visable
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: DARK_TEXT_COLOR,
                          ),
                        )
                      : null,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: hintText,
                  hintStyle: GoogleFonts.roboto(
                      color: DARK_TEXT_COLOR,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide: BorderSide(color: RED_COLOR));
  }

  OutlineInputBorder normalBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius.r),
        borderSide: BorderSide(color: Colors.transparent));
  }
}
