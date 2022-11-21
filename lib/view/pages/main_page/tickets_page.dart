import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/buttons/custom_button.dart';
import 'package:movie_flutterr/view/pages/ticket_view_page.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "My Tickets",
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
          )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Text(
                  "Today's ",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "tickets",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            todaysTickets(context),
            SizedBox(
              height: 25.h,
            ),
            Wrap(
              children: [
                Text(
                  "Upcoming ",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "tickets",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            upComingTickets(context)
          ],
        ),
      ),
    );
  }

  Widget todaysTickets(context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ticket(context);
        },
      ),
    );
  }

  Widget upComingTickets(context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ticket(context);
        },
      ),
    );
  }

  Widget ticket(context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250.w,
            height: 150.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(Assets.SMALL_TICKET),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 75,
                        height: 100,
                        decoration: BoxDecoration(
                            color: BACKGROUND_COLOR,
                            borderRadius: BorderRadius.circular(5.r)),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Movie Name",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 15,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(Assets.TIME_ICON),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Movie Time",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 15,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(Assets.SEAT_TICKET_ICON),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Number of Seats",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Expanded(
                            child: CustomButtonOne(
                                height: 20,
                                width: 80,
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewTicket(
                                            seats: "D4. D5",
                                            date: DateTime.now(),
                                            time: "9:00pm",
                                            price: "100 EGP",
                                            movieName: "Movie Name",
                                            afterBooking: false),
                                      ));
                                },
                                buttonTitle: "View Ticket"),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
