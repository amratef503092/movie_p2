

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';

class Header extends StatelessWidget {
  Header({Key? key , required this.pageName}) : super(key: key);

  String pageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            Assets.LOGO,
            width: 110.w,
            height: 95.h,
          ),
        ),
        SizedBox(
          height: 33.h,
        ),
        Center(
          child: Text(
            pageName,
            style: GoogleFonts.salsa(
                fontSize: 38.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}