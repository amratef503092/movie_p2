import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

import '../../../constants/assets.dart';
import '../../../model/user_model/getMyTickets.dart';
import '../../components/buttons/custom_button.dart';
import '../ticket_view_page.dart';
import '../user/modify_screen.dart';
import 'info_ticket.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context)
        .getTicketCineam(cinemaID: AuthCubit
        .get(context)
        .userModel!
        .cinemaID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return (state is GetMyTicketsLoading)
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Scaffold(
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
                SizedBox(
                  height: 25.h,
                ),
                todaysTickets(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget todaysTickets(context) {
    return Expanded(
      child: ListView.builder(
        itemCount: MainPageCubit.get(context).tiketUser.length,
        itemBuilder: (context, index) {
          return ticket(
              context,
              MainPageCubit.get(context)
                  .tiketUser
              [index],index);
        },
      ),
    );
  }

  Widget ticket(context, TicketsModel getTicket , index) {
    String ?  image  ;
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Name Movie : ${getTicket.movieName}",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "order Status: ${getTicket.orderStatus}",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          // Text(
                          //   "Cinema Name : ${MainPageCubit.get(context).cinema[index].name}",
                          //   style: GoogleFonts.roboto(
                          //       color: Colors.white,
                          //       fontSize: 14.sp,
                          //       fontWeight: FontWeight.w700),
                          // ),

                          Row(
                            mainAxisAlignment:  MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.TIME_ICON,
                                  width: 20.w, height: 20.h),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                getTicket.time,
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              CustomButtonOne(
                                  height: 20,
                                  width: 80,
                                  onClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => infoScreen(
                                            userID: getTicket.userID,
                                              orderStatus: getTicket.orderStatus,
                                              cinema: MainPageCubit.get(context).cinema[index],
                                              date: getTicket.date,
                                              time: getTicket.time,
                                              price: getTicket.totalPrice.toString(),
                                              movieName: getTicket.movieName,
                                              ticketID: getTicket.ticketId,
                                              afterBooking: false),
                                        ));
                                  },
                                  buttonTitle: "View Ticket"),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
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
