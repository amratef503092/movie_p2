import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/hover_icon.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w),
              child: Text("or connect with",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400)),
            ),
            const Expanded(
              child: Divider(
                color: Colors.white,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HoverIcon(btnIndex: 0, imageName: Assets.TWITTER_ICON),
              HoverIcon(
                btnIndex: 1,
                imageName: Assets.FACEBOOK_ICON,
              ),
              HoverIcon(
                btnIndex: 2,
                imageName: Assets.GOOGLE_ICON,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 45.h,
        ),
        Center(
          child: Text(
            "Enter as a guest",
            style: GoogleFonts.roboto(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: RED_COLOR,
                decoration: TextDecoration.underline),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
