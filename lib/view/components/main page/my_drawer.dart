import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/pages/auth/login_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2 , sigmaY: 2),
      child: Container(
        width: 230.w,
        height: 800.h,
        color: BACKGROUND_COLOR,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: RED_COLOR,
                        borderRadius: BorderRadius.circular(100.r)),
                    child: Padding(
                      padding: EdgeInsets.all(1.5),
                      child: CircleAvatar(
                        backgroundColor: BACKGROUND_COLOR,
                      ),
                    ),
                  ),
                  SizedBox(width: 25.w,)
                  ,Text(
                    user != null ? user!.name : "User Name",
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: 45.h,
              ),
              myCustomRow("Account", Assets.ACCOUNT_ICON),
              SizedBox(
                height: 45.h,
              ),
              myCustomRow("Settings", Assets.SETTINGS_ICON),
              SizedBox(
                height: 45.h,
              ),
              myCustomRow("About", Assets.ABOUT_ICON),
              SizedBox(
                height: 45.h,
              ),
              GestureDetector(
                  onTap: () {
                    TOKEN = "";
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: myCustomRow("Logout", Assets.LOGOUT_ICON)),
            ],
          ),
        ),
      ),
    );
  }

  Widget myCustomRow(String title, String image) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Row(
            children: [
              Image.asset(image),
              SizedBox(
                width: 20.w,
              ),
              Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
