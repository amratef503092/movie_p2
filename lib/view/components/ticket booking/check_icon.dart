import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/constants.dart';

class CheckIcon extends StatelessWidget {
  const CheckIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.sp,
      width: 150.sp,
      child: Stack(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
            ),
          )),
          Center(
            child: Icon(
              Icons.check_circle_rounded,
              color: RED_COLOR,
              size: 150.sp,
            ),
          ),
        ],
      ),
    );
  }
}
