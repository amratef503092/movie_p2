import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/model/movies/released_movie.dart';
import 'package:movie_flutterr/model/movies/upcoming_movie.dart';
import 'package:movie_flutterr/view/components/home/released_card.dart';
import 'package:movie_flutterr/view/components/home/upcoming_card.dart';
import 'package:movie_flutterr/view_model/cubit/home%20page/home_page_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

class HomePage extends StatelessWidget {
  HomePage(
      {Key? key, required this.releasedMovies, required this.upComingMovies})
      : super(key: key);

  List<ReleasedMovie> releasedMovies;
  List<UpComingMovie> upComingMovies;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          HomePageCubit myCubit = HomePageCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Image.asset(
                Assets.LOGO,
                width: 40.w,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: backGround(myCubit.currentReleasedMovie >
                                  releasedMovies.length - 1
                              ? myCubit.currentReleasedMovie -
                                  releasedMovies.length
                              : myCubit.currentReleasedMovie),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pageTitle(),
                            releasedMoviesSwiper(myCubit),
                            SizedBox(
                              height: 50.h,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 30.0.w, bottom: 30.h),
                              child: Text("Coming Soon",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.sp)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    upComingMoviesSwiper()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget backGround(int index) {
    return Stack(
      children: [
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.25,
              child: releasedMovies.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: releasedMovies[index].image!,
                              fit: BoxFit.fill)),
                    )
                  : null,
            )),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  BACKGROUND_COLOR,
                  BACKGROUND_COLOR.withOpacity(0.8),
                  BACKGROUND_COLOR.withOpacity(0.3),
                  BACKGROUND_COLOR.withOpacity(0.1),
                  BACKGROUND_COLOR.withOpacity(0.3),
                  BACKGROUND_COLOR.withOpacity(0.8),
                  BACKGROUND_COLOR,
                ]),
          ),
        ),
        /*Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  BACKGROUND_COLOR.withOpacity(0.5),
                  BACKGROUND_COLOR
                ]),
          ),
        ),*/
      ],
    );
  }

  Widget pageTitle() {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: Text(
            "Now Playing",
            style: GoogleFonts.salsa(
                fontSize: 33.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Center(
          child: Text(
            "Book your ticket now",
            style: GoogleFonts.salsa(
                fontSize: 10.sp, fontWeight: FontWeight.w400, color: RED_COLOR),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  Widget releasedMoviesSwiper(HomePageCubit myCubit) {
    return SizedBox(
      height: 280.h,
      width: 360.w,
      child: Swiper(
        onIndexChanged: (value) {
          print(value);
          myCubit.changeReleasedMovie(value);
        },
        index: myCubit.currentReleasedMovie,
        layout: SwiperLayout.CUSTOM,
        customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 9)
          ..addRotate([
            -80 / 480,
            -60 / 480,
            -40.0 / 180,
            -20.0 / 180,
            0.0,
            20.0 / 180,
            40.0 / 180,
            60 / 480,
            80 / 480
          ])
          ..addTranslate([
            Offset(-1640.0, -40.0),
            Offset(-820.0, -20.0),
            Offset(-420.0, -10.0),
            Offset(-210.0, -5.0),
            Offset(0.0, 0.0),
            Offset(210.0, -5.0),
            Offset(420.0, -10.0),
            Offset(820.0, -20.0),
            Offset(1640.0, -40.0),
          ]),
        itemWidth: 200,
        pagination: const SwiperPagination(
            margin: EdgeInsets.zero,
            builder: DotSwiperPaginationBuilder(
                activeSize: 15,
                size: 12,
                activeColor: RED_COLOR,
                color: TEXT_FIELD_BACKGROUND_COLOR)),
        itemCount: releasedMovies.length,
        itemBuilder: (context, index) {
          return ReleasedMovieCard(
            movie: releasedMovies[index > releasedMovies.length - 1
                ? index - releasedMovies.length
                : index],
          );
        },
      ),
    );
  }

  //create a generator for rotation and positions depends on list length

  Widget upComingMoviesSwiper() {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Swiper(
                  loop: true,
                  autoplay: true,
                  autoplayDisableOnInteraction: true,
                  viewportFraction: 0.7,
                  scale: 0.8,
                  scrollDirection: Axis.horizontal,
                  itemCount: upComingMovies.length,
                  itemBuilder: ((context, index) {
                    return UpComingMovieCard(
                      movie: upComingMovies[index],
                    );
                  })))
        ],
      ),
    );
  }
}
