import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/pages/main_page/home_page.dart';
import 'package:movie_flutterr/view/pages/main_page/search_page.dart';
import 'package:movie_flutterr/view/pages/main_page/tickets_page.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

import '../components/main page/bottom_nav.dart';
import '../components/main page/my_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainPageCubit()
        ..getReleasedMoviesData()
        ..getUpComingMoviesData(),
      child: BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) {
          MainPageCubit myCubit = MainPageCubit.get(context);

          List<Movie> searchList = [];
          searchList.addAll(myCubit.releasedMovies);
          searchList.addAll(myCubit.upComingMovies);
          
          return Scaffold(
            bottomNavigationBar: CustomBottomNavBar(myCubit: myCubit),
            backgroundColor: BACKGROUND_COLOR,
            drawer: const MyDrawer(),
            body: Stack(
              children: [
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    myCubit.swipePage(value);
                  },
                  controller: myCubit.pageController,
                  children: [
                    HomePage(
                        releasedMovies: myCubit.releasedMovies,
                        upComingMovies: myCubit.upComingMovies),
                    TicketsPage(),
                    SearchPage(movies: searchList)
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  alignment: Alignment.centerLeft,
                  width: 360.w,
                  height: 80.h,
                  child: Container(
                    height: 50.h,
                    child: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Image.asset(Assets.MENU_ICON),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
