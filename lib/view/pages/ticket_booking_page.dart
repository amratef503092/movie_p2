import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/pages/reservation/checkout_page.dart';
import 'package:movie_flutterr/view/pages/reservation/checkout_completed.dart';
import 'package:movie_flutterr/view/pages/reservation/reservation_page.dart';
import 'package:movie_flutterr/view_model/cubit/ticket%20booking/ticket_booking_cubit.dart';

class TicketBookingPage extends StatelessWidget {
  TicketBookingPage({Key? key, required this.dateTime, required this.movie})
      : super(key: key);

  DateTime dateTime;
  String currentPageTitle = "Reservation";
  Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketBookingCubit()..instialize(context),
      child: BlocBuilder<TicketBookingCubit, TicketBookingState>(
        builder: (context, state) {
          TicketBookingCubit myCubit = TicketBookingCubit.get(context);
          return WillPopScope(
            onWillPop: () async {
              myCubit.backButtonFunction(context);
              return false;
            },
            child: Scaffold(
              backgroundColor: BACKGROUND_COLOR,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    myCubit.backButtonFunction(context);
                  },
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: BACKGROUND_COLOR,
                title: Text(
                  currentPageTitle,
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: RED_COLOR,
                    width: 360.w / myCubit.barDividerNumber,
                    height: 1.h,
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: myCubit.pageController,
                      children: [
                        ReservationPage(
                            myCubit: myCubit,
                            movieName: movie.name!,
                            movieTime: movie.duration!)
                          ..setTimeList(),
                        CheckoutPage(
                            myCubit: myCubit,
                            movieName: movie.name!,
                            date: dateTime),
                        CheckoutCompletedPage(
                          movieDate: dateTime,
                          myCubit: myCubit,
                          movieName: movie.name!,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
