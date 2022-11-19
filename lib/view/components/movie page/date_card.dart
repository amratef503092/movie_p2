import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_flutterr/constants/constants.dart';

class DateCard extends StatelessWidget {
  DateCard(
      {Key? key,
      required this.dateTime,
      required this.isSelected,
      required this.onClick})
      : super(key: key);

  DateTime dateTime;
  bool isSelected;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    String month = DateFormat("MMMM").format(dateTime);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onClick();
            },
            child: Card(
              color: isSelected ? RED_COLOR : TEXT_FIELD_BACKGROUND_COLOR,
              child: SizedBox(
                width: 60,
                height: 80,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          '${dateTime.day < 10 ? 0 : ""}${dateTime.day}',
                          style: GoogleFonts.roboto(
                              fontSize: 23.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (month.length > 6)
                        SizedBox(
                          height: 3.h,
                        ),
                      FittedBox(
                        child: Text(
                          month,
                          style: GoogleFonts.roboto(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
