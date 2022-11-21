import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/view/components/buttons/custom_button.dart';
import 'package:movie_flutterr/view/components/ticket%20booking/check_icon.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view/pages/ticket_view_page.dart';
import 'package:movie_flutterr/view_model/cubit/ticket%20booking/ticket_booking_cubit.dart';

class CheckoutCompletedPage extends StatelessWidget {
  CheckoutCompletedPage(
      {Key? key,
      required this.myCubit,
      required this.movieDate,
      required this.movieName})
      : super(key: key);

  DateTime movieDate;
  String movieName;
  TicketBookingCubit myCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pageTitle(),
        SizedBox(
          height: 50.h,
        ),
        CheckIcon(),
        SizedBox(
          height: 50.h,
        ),
        buttons(context)
      ],
    );
  }

  Widget pageTitle() {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
        ),
        Text(
          "Congrats",
          style: GoogleFonts.salsa(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 42.sp),
        ),
        SizedBox(
          height: 25.h,
        ),
        Text(
          "Reservation Completed",
          style: GoogleFonts.salsa(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 19.sp),
        ),
      ],
    );
  }

  Widget buttons(context) {
    return Column(
      children: [
        CustomButtonOne(
            onClick: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewTicket(
                          afterBooking: true,
                          seats: myCubit.seats.join(", "),
                          date: movieDate,
                          time: myCubit.movieTime,
                          price: '${myCubit.totalPrice} EGP',
                          movieName: movieName)),
                  (route) => false);
            },
            buttonTitle: "View Ticket"),
        SizedBox(
          height: 35.h,
        ),
        CustomButtonOne(
          onClick: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
                (route) => false);
          },
          buttonTitle: "Back to home",
          isFilled: false,
        )
      ],
    );
  }
}
