import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/cinema_owner_model/cinema_model.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view/pages/user/show_snacks.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import '../../view_model/cubit/main page/main_page_cubit.dart';
import '../chat_screen.dart';

class ViewTicket extends StatefulWidget {
  ViewTicket({
    Key? key,
    required this.date,
    required this.time,
    required this.price,
    required this.movieName,
    required this.afterBooking,
    required this.ticketID,
    required this.orderStatus,
    required this.cinemaID
  }) : super(key: key);
  String date;
  String orderStatus;
  String cinemaID;
  String time;
  String price;
  String movieName;
  bool afterBooking;
  String ticketID;

  @override
  State<ViewTicket> createState() => _ViewTicketState();
}

class _ViewTicketState extends State<ViewTicket> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getMySnacks(ticketId: widget.ticketID);
    MainPageCubit.get(context).getCineamInfo(cinemaID: widget.cinemaID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orderStatus);
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return (MainPageCubit.get(context).cinemaInfo == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: BACKGROUND_COLOR,
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (widget.afterBooking) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
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
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return ChatScreen(
                              receiverId: MainPageCubit.get(context).cinemaInfo!.id
                              ,receiverName:
                            MainPageCubit.get(context).cinemaInfo!.name,
                              cinemaID: MainPageCubit.get(context).cinemaInfo!.id,
                              userID: FirebaseAuth.instance.currentUser!.uid,
                              cinema: false,
                              );
                        },));
                      },
                      icon: Icon(Icons.chat),
                    )
                  ],
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
                            height: 50.h,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowSnaks(
                                          cinemaID: MainPageCubit.get(context).cinemaInfo!.id,
                                              orderStasus: widget.orderStatus,
                                              ticketID: widget.ticketID,
                                            )));
                              },
                              child: Text("Show Snacks"))
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget ticketInfo() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Movie: ${widget.movieName}",
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 40),
        // ticketInfoRow("Name", user!.name, "Seats", seats),
        ticketInfoRow("Cinema Name ", MainPageCubit.get(context).cinemaInfo!.name, "address",
            MainPageCubit.get(context).cinemaInfo!.address),
        SizedBox(height: 30),

        ticketInfoRow("Date", widget.date, "Time", widget.time),
        SizedBox(height: 30),
        ticketInfoRow("NP Order", widget.ticketID, "Price", widget.price),
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
