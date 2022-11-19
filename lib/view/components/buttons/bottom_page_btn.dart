import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';

class BottomPageButton extends StatelessWidget {
  BottomPageButton({Key? key, required this.onClick, required this.title})
      : super(key: key);

  String title;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 75.h,
        width: 360.w,
        color: RED_COLOR,
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.roboto(
                fontSize: 24.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
