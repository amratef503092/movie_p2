import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/pages/auth/login_page.dart';
import 'package:movie_flutterr/view/pages/user/EditInfo.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import '../../../view_model/database/local/cache_helper.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            width: 230.w,
            height: 800.h,
            color: BACKGROUND_COLOR,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                  vertical:   50.h
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(

                        radius: 20.r,
                        backgroundImage: NetworkImage(
                            AuthCubit.get(context).userModel!.photo!),

                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        user != null ? user!.name : AuthCubit.get(context).userModel!.name,
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  InkWell(onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const EditUserInfo();
                    },));
                  }
                      ,child: myCustomRow("Settings", Assets.SETTINGS_ICON)),
                  SizedBox(
                    height: 45.h,
                  ),
                  GestureDetector(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(CacheHelper.get(key: 'id'))
                            .update({
                          'online': false,
                        }).then((value) async {
                          await FirebaseAuth.instance.signOut();
                        }).then((value) async {
                          await CacheHelper.removeData(key: 'id');
                          await CacheHelper.removeData(key: 'role');

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                                  (route) => false);
                        });
                      },
                      child: myCustomRow("Logout", Assets.LOGOUT_ICON)),
                ],
              ),
            ),
          ),
        );
      },
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
