import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.onClick,
      required this.buttonTitle,
      this.isFilled = true,
      this.width = 250,
      this.height = 50})
      : super(key: key);

  String buttonTitle;
  VoidCallback onClick;
  bool isFilled;
  double width;
  int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: RED_COLOR),
          color: isFilled ? RED_COLOR : Colors.transparent),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: SizedBox(
          width: width.w,
          height: height.h,
          child: Center(
            child: Text(
              buttonTitle,
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp),
            ),
          ),
        ),
      ),
    );
  }
}
