import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/assets.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/cinema_owner_model/cinema_model.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/userInfo.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view/pages/user/show_snacks.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import '../../../view_model/cubit/main page/main_page_cubit.dart';

class infoScreen extends StatefulWidget {
  infoScreen({
    Key? key,
    required this.userID,
    required this.date,
    required this.time,
    required this.price,
    required this.movieName,
    required this.afterBooking,
    required this.ticketID,
    required this.cinema,
    required this.orderStatus,
  }) : super(key: key);
  CinemaModel cinema;
  String userID;
  String date;
  String orderStatus;
  String time;
  String price;
  String movieName;
  bool afterBooking;
  String ticketID;

  @override
  State<infoScreen> createState() => _infoScreenState();
}

class _infoScreenState extends State<infoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getMySnacks(ticketId: widget.ticketID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orderStatus);
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        if(state is CancelOrderSuccess)
        {
          MainPageCubit.get(context)
              .getTicketCineam(cinemaID:
          AuthCubit
              .get(context)
              .userModel!
              .cinemaID);
          Navigator.maybePop(context);
        }
        if(state is AcceptedOrderSuccess)
        {
          MainPageCubit.get(context)
              .getTicketCineam(cinemaID: AuthCubit
              .get(context)
              .userModel!
              .cinemaID);
          Navigator.maybePop(context);

        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return (state is GetMySnacksLoading)
            ? const Center(
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
            actions: [
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return ChatScreen(
              //         receiverId: widget.cinema.id,receiverName:
              //       widget.cinema.name,
              //         cinemaID: widget.cinema.id,
              //         userID: FirebaseAuth.instance.currentUser!.uid,
              //         cinema: false,
              //       );
              //     },));
              //   },
              //   icon: Icon(Icons.chat),
              // )
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                height: 0.5.sh,
                top: 500,
                child: (widget.orderStatus != 'Pending')? SizedBox():Row(
                  children: [
                    ElevatedButton(onPressed: ()
                    {

                      MainPageCubit.get(context).accepted(widget.ticketID);


                    }, child: const Text("Accepted")),
                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: () {

                      MainPageCubit.get(context).cancelOrder(widget.ticketID);

                    }, child: const Text("Rejected")),
                  ],
                ),
              ),
              Image.asset(Assets.TICKET),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ticketInfo(),
                    SizedBox(
                      height: 30.h,
                    ),
                    ElevatedButton
                      (
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowSnaks(
                                    cinemaID: widget.cinema.id,
                                    orderStasus: widget.orderStatus,
                                    ticketID: widget.ticketID,
                                  )));
                        },
                        child: const Text("Show Snacks")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserInfoScreen(
                                    userID: widget.userID,
                                    cinemaID: widget.cinema.id,
                                    orderStatus: widget.orderStatus,
                                    ticketID: widget.ticketID,
                                  )));
                        },
                        child: const Text("Show User Info")),
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
        ticketInfoRow("Cinema Name ", widget.cinema.name, "address",
            widget.cinema.address),
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
