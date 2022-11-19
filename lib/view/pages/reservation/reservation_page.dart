import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/buttons/bottom_page_btn.dart';
import 'package:movie_flutterr/view/components/ticket%20booking/high_light.dart';
import 'package:movie_flutterr/view/components/toast.dart';
import 'package:movie_flutterr/view_model/cubit/ticket%20booking/ticket_booking_cubit.dart';

class ReservationPage extends StatelessWidget {
  ReservationPage(
      {Key? key,
      required this.myCubit,
      required this.movieName,
      required this.movieTime})
      : super(key: key);

  String movieName;
  int movieTime;
  TicketBookingCubit myCubit;
  List<String> timeList = ['12:00pm'];

  int timeListIndex = 0;

  void setTimeList() {
    int time = (movieTime + 30) - ((movieTime + 30) % 30);
    if (time - movieTime < 10) time += 30;
    int hour = 0;
    bool listFilled = false;
    for (int i = 1; !listFilled; i++) {
      hour += (time ~/ 60) + (i % 2 == 0 && time % 60 != 0 ? 1 : 0);
      if (hour > 12) {
        listFilled = true;
        continue;
      }
      timeList.add(
          "$hour:${time % 60 != 0 ? i % 2 != 0 ? "30" : "00" : "00"}${hour == 12 ? "am" : "pm"}");
    }
  }

  @override
  Widget build(BuildContext context) {
    getTimePositions();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          titleMovieNameText(),
          SizedBox(
            height: 30.h,
          ),
          Stack(
            children: [
              timeSwiper(),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: BoxDecoration(
                      color: RED_COLOR,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 45.h),
                child: const HighLight(),
              )),
              seats()
            ],
          ),
          SizedBox(
            height: 65.h,
          ),
          seatsDescription(),
          SizedBox(height: 50.h),
          checkoutInfo(),
          SizedBox(
            height: 30.h,
          ),
          BottomPageButton(
              onClick: () {
                if (myCubit.seats.isNotEmpty) {
                  myCubit.movieTime = timeList[timeListIndex];
                  myCubit.changePage(1);
                } else {
                  showToast(message: "You should chose your seats");
                }
              },
              title: "Checkout")
        ],
      ),
    );
  }

  Widget titleMovieNameText() {
    return Text(
      movieName,
      style: GoogleFonts.roboto(
          color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
    );
  }

  Widget timeSwiper() {
    return Stack(
      children: [
        SizedBox(
          height: 50.h,
          width: 360.w,
          child: Swiper(
            onIndexChanged: (index) {
              timeListIndex = (index - 1) % timeList.length;
            },
            index: (timeList.length / 2).ceil(),
            layout: SwiperLayout.CUSTOM,
            customLayoutOption: CustomLayoutOption(
                startIndex: -1, stateCount: timeList.length * 2)
              ..addTranslate(getTimePositions())
              ..addScale(getTimeScales(), Alignment.bottomCenter),
            itemWidth: 70.w,
            itemCount: timeList.length,
            itemBuilder: (context, index) {
              return Text(
                timeList[index % timeList.length],
                style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: Container(
            width: 90.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  BACKGROUND_COLOR,
                  BACKGROUND_COLOR.withOpacity(0.95),
                  BACKGROUND_COLOR.withOpacity(0.7),
                  BACKGROUND_COLOR.withOpacity(0.0),
                ])),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Container(
            width: 90.w,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                  BACKGROUND_COLOR,
                  BACKGROUND_COLOR.withOpacity(0.95),
                  BACKGROUND_COLOR.withOpacity(0.7),
                  BACKGROUND_COLOR.withOpacity(0.0),
                ])),
          ),
        ),
      ],
    );
  }

  List<Offset> getTimePositions() {
    List<Offset> positions = [];

    for (int i = timeList.length; i > 0; i--) {
      positions.add(Offset(i * -70, i * 10));
    }

    positions.add(const Offset(0, 0));

    for (int i = 0; i < timeList.length - 1; i++) {
      positions.add(Offset((i + 1) * 70, (i + 1) * 10));
    }
    return positions;
  }

  List<double> getTimeScales() {
    List<double> scales = [];

    for (int i = 0; i < timeList.length; i++) {
      scales.add(0.6);
    }

    scales.add(1);

    for (int i = 0; i < timeList.length - 1; i++) {
      scales.add(0.6);
    }
    return scales;
  }

  Widget seats() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 130 , left: 50 , right: 50),
        child: SizedBox(
            height: 275.h,
            child: Column(
              children: [
                Expanded(child: seatsRow(8, "B")),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: seatsRow(9, "C")),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: seatsRow(8, "D")),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: seatsRow(9, "E")),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: seatsRow(8, "F")),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: seatsRow(9, "G")),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: seatsRow(8, "H")),
              ],
            )),
      ),
    );
  }

  Widget seatsRow(int numberOfSeats, String rowCode) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: numberOfSeats,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: GestureDetector(
                onTap: () {
                  myCubit.selectSeat("$rowCode${index + 1}");
                },
                child: Image.asset(
                    myCubit.seats.contains("$rowCode${index + 1}")
                        ? Assets.SEAT_SELECTED
                        : Assets.SEAT_EMTY)),
          );
        });
  }

  Widget seatsDescription() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset(
              Assets.SEAT_RESERVED,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text("Reserved",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700))
          ],
        ),
        SizedBox(
          width: 25.w,
        ),
        Row(
          children: [
            Image.asset(
              Assets.SEAT_EMTY,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text("Available",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700))
          ],
        ),
        SizedBox(
          width: 25.w,
        ),
        Row(
          children: [
            Image.asset(
              Assets.SEAT_SELECTED,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text("Selected",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700))
          ],
        )
      ],
    );
  }

  Widget checkoutInfo() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset(
              Assets.MONEY_ICON,
              width: 26.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text("${myCubit.totalPrice} EGP",
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700))
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Container(
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.white),
        ),
        SizedBox(
          width: 20.w,
        ),
        Text("${myCubit.seats.length} Seats Selected",
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700))
      ],
    );
  }
}
