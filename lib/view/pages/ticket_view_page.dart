import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';

class ViewTicket extends StatelessWidget {
  ViewTicket(
      {Key? key,
      required this.seats,
      required this.date,
      required this.time,
      required this.price,
      required this.movieName,
      required this.afterBooking})
      : super(key: key);

  String seats;
  DateTime date;
  String time;
  String price;
  String movieName;
  bool afterBooking;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (afterBooking) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
              (route) => false);
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (afterBooking) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "View Ticket",
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(Assets.TICKET),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ticketInfo(),
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(Assets.QR_CODE)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ticketInfo() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Movie: $movieName",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 40),
        ticketInfoRow("Name", user!.name, "Seats", seats),
        SizedBox(height: 30),
        ticketInfoRow(
            "Date", DateFormat("d MMM yyyy").format(date), "Time", time),
        SizedBox(height: 30),
        ticketInfoRow("NP Order", "7283603745", "Price", price),
      ],
    );
  }

  Widget ticketInfoRow(
      String header1, String content1, String header2, String content2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 2, child: ticketInfoItem(header1, content1)),
        Expanded(flex: 1, child: ticketInfoItem(header2, content2))
      ],
    );
  }

  Widget ticketInfoItem(String header, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: GoogleFonts.roboto(
              color: DARK_TEXT_COLOR,
              fontSize: 9.sp,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            content,
            style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
