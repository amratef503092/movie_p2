import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/buttons/bottom_page_btn.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view_model/cubit/ticket%20booking/ticket_booking_cubit.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage(
      {Key? key,
      required this.myCubit,
      required this.movieName,
      required this.date})
      : super(key: key);

  DateTime date;
  String movieName;

  TicketBookingCubit myCubit;

  TextEditingController visaNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 30.h,
      ),
      titleMovieNameText(),
      SizedBox(
        height: 20.h,
      ),
      movieTime(),
      SizedBox(
        height: 20.h,
      ),
      infoCard(),
      Padding(
        padding: const EdgeInsets.only(top: 15, left: 30),
        child: Text(
          "Payment Info",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      paymentCard(),
      SizedBox(
        height: 20.h,
      ),
      BottomPageButton(
          onClick: () {
            myCubit.changePage(1);
          },
          title: "Pay Now")
    ]));
  }

  Widget titleMovieNameText() {
    return Center(
      child: Text(
        movieName,
        style: GoogleFonts.roboto(
            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget movieTime() {
    return Center(
      child: Text(
        '${date.day == DateTime.now().day ? "Today | " : date.day == DateTime.now().day + 1 ? "Tomorrow | " : ""}${DateFormat("d MMM").format(date)} | ${myCubit.movieTime}',
        style: GoogleFonts.roboto(
            color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget infoCard() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: TEXT_FIELD_BACKGROUND_COLOR),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "NP Order",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "7283603745",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: BACKGROUND_COLOR,
                width: 250.w,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Info",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      movieName,
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: BACKGROUND_COLOR,
                width: 250.w,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Session",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${myCubit.movieTime} , ${DateFormat("d MMM").format(date)}",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: BACKGROUND_COLOR,
                width: 250.w,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Seats",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      myCubit.seats.join(", "),
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: BACKGROUND_COLOR,
                width: 250.w,
                height: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${myCubit.totalPrice} EGP',
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentCard() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff262626), Color(0xff262626).withOpacity(0.35)]),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(Assets.VISA_BACK_CIRCLE_TOP)),
            Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(Assets.VISA_BACK_CIRCLE_BOTTOM)),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomTextField(
                        fieldValidator: (value) {
                          if (value.isEmpty) {
                            return "Please enter your card number";
                          }
                          return null;
                        },
                          controller: visaNumberController,
                          hint: ""),
                      if (visaNumberController.text.trim().isEmpty)
                        IgnorePointer(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("XXXX",
                                    style: GoogleFonts.roboto(
                                        color: DARK_TEXT_COLOR,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                                Text("XXXX",
                                    style: GoogleFonts.roboto(
                                        color: DARK_TEXT_COLOR,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                                Text("XXXX",
                                    style: GoogleFonts.roboto(
                                        color: DARK_TEXT_COLOR,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                                Text("XXXX",
                                    style: GoogleFonts.roboto(
                                        color: DARK_TEXT_COLOR,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          fieldValidator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your card holder name";
                            }},
                            controller: visaNumberController,
                            hint: "00"),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: CustomTextField(
                          fieldValidator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your card holder name";
                            }
                            return null;
                          },
                            controller: visaNumberController,
                            hint: "00"),

                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomTextField(
                              fieldValidator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter your card holder name";
                                }
                                return null;
                              },
                                controller: visaNumberController,
                                hint: ""

                                ),
                            if (visaNumberController.text.trim().isEmpty)
                              IgnorePointer(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("*",
                                          style: GoogleFonts.roboto(
                                              color: DARK_TEXT_COLOR,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500)),
                                      Text("*",
                                          style: GoogleFonts.roboto(
                                              color: DARK_TEXT_COLOR,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500)),
                                      Text("*",
                                          style: GoogleFonts.roboto(
                                              color: DARK_TEXT_COLOR,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
