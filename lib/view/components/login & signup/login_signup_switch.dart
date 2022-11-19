import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/constants.dart';

class LoginSignUpSwitcher extends StatelessWidget {
  LoginSignUpSwitcher(
      {Key? key,
      required this.navigatorFunction,
      required this.clickableTitle,
      required this.title})
      : super(key: key);

  VoidCallback navigatorFunction;
  String title;
  String clickableTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Colors.white),
        ),
        GestureDetector(
          onTap: navigatorFunction,
          child: Text(
            clickableTitle,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600, fontSize: 16.sp, color: RED_COLOR),
          ),
        )
      ],
    );
  }
}
