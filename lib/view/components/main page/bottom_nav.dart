import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({Key? key, required this.myCubit}) : super(key: key);

  MainPageCubit myCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360.w,
      height: 75.h,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            navItem(
                myCubit: myCubit,
                itemIndex: 0,
                size: 20,
                icon: Assets.HOME_ICON),
            SizedBox(
              width: 95.w,
            ),
            navItem(
                myCubit: myCubit,
                itemIndex: 1,
                size: 25,
                icon: Assets.TICKECT_ICON),
            SizedBox(
              width: 95.w,
            ),
            navItem(
                myCubit: myCubit,
                itemIndex: 2,
                size: 25,
                icon: Assets.SEARCH_ICON),
          ],
        ),
      ),
    );
  }

  Widget navItem(
      {required MainPageCubit myCubit,
      required int itemIndex,
      required double size,
      required String icon}) {
    return GestureDetector(
      onTap: () {
        myCubit.changePage(itemIndex);
      },
      child: Image.asset(
        icon,
        width: size,
        color: myCubit.currentPageIndex == itemIndex ? RED_COLOR : null,
      ),
    );
  }
}
