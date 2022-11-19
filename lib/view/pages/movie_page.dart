import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/components/buttons/bottom_page_btn.dart';
import 'package:movie_flutterr/view/components/movie%20page/cast_card.dart';
import 'package:movie_flutterr/view/components/movie%20page/date_card.dart';
import 'package:movie_flutterr/view/pages/ticket_booking_page.dart';
import 'package:movie_flutterr/view_model/cubit/movie%20page/movie_page_cubit.dart';

class MoviePage extends StatelessWidget {
  MoviePage({Key? key, required this.movie}) : super(key: key);

  Movie movie;
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    dateTime = DateTime.now();
    return BlocProvider(
      create: (context) => MoviePageCubit()..initialize(),
      child: BlocBuilder<MoviePageCubit, MoviePageState>(
        builder: (context, state) {
          MoviePageCubit myCubit = MoviePageCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: BACKGROUND_COLOR,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  header(),
                  movieDetails(),
                  SizedBox(
                    height: 15.h,
                  ),
                  ratingStars(),
                  movieOverview(),
                  SizedBox(
                    height: 25.h,
                  ),
                  castAndCrew(),
                  SizedBox(
                    height: 15.h,
                  ),
                  selectDate(myCubit),
                  SizedBox(
                    height: 25.h,
                  ),
                  BottomPageButton(
                    onClick: () {
                      print("Here");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketBookingPage(
                                dateTime: myCubit.selectedDate! , movie: movie,),
                          ));
                    },
                    title: "Reservation",
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return SizedBox(
      width: 360.w,
      height: 280.h,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: movie.image!, fit: BoxFit.cover)),
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.transparent,
              BACKGROUND_COLOR
            ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              color: BACKGROUND_COLOR.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
          Positioned(
              left: 50,
              right: 50,
              bottom: 15,
              child: Text(
                movie.name!,
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }

  Widget movieDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "PG-${movie.adult! ? 17 : 3}",
            textAlign: TextAlign.right,
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                  color: RED_COLOR, borderRadius: BorderRadius.circular(100.r)),
            ),
          ),
          Text(
            "${(((movie.duration! - (movie.duration! % 60)) / 60) % 24).toInt()}h ${movie.duration! % 60}m",
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                  color: RED_COLOR, borderRadius: BorderRadius.circular(100.r)),
            ),
          ),
          Flexible(
            child: Text(
              movie.genres!.replaceAll(',', '|'),
              style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget ratingStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: SizedBox()),
        RatingBar(
          ignoreGestures: true,
          minRating: 1,
          maxRating: 10,
          initialRating: movie.rating!.floor() / 2,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30.w,
          onRatingUpdate: (value) {},
          ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_rounded,
                color: RED_COLOR,
              ),
              empty: Icon(
                Icons.star_rounded,
                color: TEXT_FIELD_BACKGROUND_COLOR,
              ),
              half: Icon(
                Icons.star_half_rounded,
                color: RED_COLOR,
              )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: Text(
              '${movie.rating!.toDouble()}',
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    );
  }

  Widget movieOverview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Synopsis',
            style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
            child: Text(
              movie.overview!,
              style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget castAndCrew() {
    return SizedBox(
      height: 155.h,
      width: 360.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cast & Crew',
                  style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Text(
                      'See All',
                      style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right_outlined,
                      color: RED_COLOR,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return CastCard(name: "Actor", image: "");
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget selectDate(MoviePageCubit myCubit) {
    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Text(
              'Select Date',
              style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Stack(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      DateTime cardDate = DateTime(
                          0, dateTime!.month, dateTime!.day + index - 1);
                      return DateCard(
                        dateTime: cardDate,
                        isSelected:
                            index == myCubit.selectedIndex ? true : false,
                        onClick: () {
                          if (index == 0) return;
                          myCubit.changeDate(cardDate, index);
                        },
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        width: 70,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                              BACKGROUND_COLOR,
                              Colors.transparent,
                            ])),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        width: 70,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                              Colors.transparent,
                              BACKGROUND_COLOR,
                            ])),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
