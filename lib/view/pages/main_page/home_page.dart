import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/home/upcoming_card.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/MoviesScreen.dart';
import 'package:movie_flutterr/view_model/cubit/home%20page/home_page_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

import '../user/detiles_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getReleasedMoviesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          HomePageCubit myCubit = HomePageCubit.get(context);
          return (state is GetReleasedMoviesLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
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
                      child: SizedBox(
                        width: 1.sw,
                        height: 1.sh,
                        child: Column(
                          children: [
                            upComingMoviesSwiper(),
                            SizedBox(
                              height: 20.h,
                            ),
                            Expanded(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return CustomCardMovie(
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                     value: myCubit,
                                                    child: DetailsMovieScreen(
                                                      movie: MainPageCubit.get(
                                                              context)
                                                          .movies[index],
                                                    ),
                                                  )));
                                    },
                                    title: MainPageCubit.get(context)
                                        .movies[index]
                                        .nameMovie,
                                    image: MainPageCubit.get(context)
                                        .movies[index]
                                        .image,
                                  );
                                },
                                itemCount:
                                    MainPageCubit.get(context).movies.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },

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
                  itemCount: MainPageCubit.get(context).movies.length,
                  itemBuilder: ((context, index) {
                    return UpComingMovieCard(

                      movie: MainPageCubit.get(context).movies[index],
                    );
                  })))
        ],
      ),
    );
  }
}
