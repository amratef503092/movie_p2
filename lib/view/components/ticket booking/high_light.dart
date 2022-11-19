import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/assets.dart';

class HighLight extends StatelessWidget {
  const HighLight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
            top: 9,
            child: Image.asset(
              Assets.RESERVATION1,
              fit: BoxFit.fitWidth,
            )),
        Image.asset(
          Assets.RESERVATION2,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
