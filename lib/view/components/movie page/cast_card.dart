import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';

class CastCard extends StatelessWidget {
  CastCard({Key? key, required this.name, required this.image})
      : super(key: key);

  String name;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Column(
        children: [
          Container(
            width: 45.w,
            height: 70.h,
            decoration: BoxDecoration(
                color: TEXT_FIELD_BACKGROUND_COLOR,
                borderRadius: BorderRadius.circular(8.r)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.roboto(
                  fontSize: 8.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
