import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

import '../../../model/user_model/getMyTickets.dart';

class ModifyScreen extends StatefulWidget {
  ModifyScreen({Key? key, this.ticket}) : super(key: key);
  TicketsModel? ticket;

  @override
  State<ModifyScreen> createState() => _ModifyScreenState();
}

class _ModifyScreenState extends State<ModifyScreen> {
  @override
  int count = 1;

  void initState() {
    // TODO: implement initState
    print(widget.ticket!.movieID);
    MainPageCubit.get(context).getHellInfo(hallName: widget.ticket!.hallName);
    MainPageCubit.get(context).getMovieInfo(movieID: widget.ticket!.movieID);
    count = widget.ticket!.quantity;
    super.initState();
  }

  @override
  int priceAllSnacks = 0;
  String? date;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is DeleteMovieTicketsSuccess) {
          MainPageCubit.get(context).getMyTicket();
          Navigator.pop(context);
        }
        if (state is EditTicketSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ticket Edited Successfully")));
          MainPageCubit.get(context).getMyTicket();
          Navigator.maybePop(context);
          // Navigator.push(context,MaterialPageRoute(builder: (context) {
          //   return ConfirmTicket(
          //     hallName: widget.movie.hall,
          //     movieName: widget.movie.nameMovie,
          //     date: date!,
          //     time: widget.movie.time,
          //     totalPrice: count * widget.movie.price ,
          //     ticketId: state.ticketId,
          //     cinemaID: widget.movie.cinemaID,
          //
          //   );
          //
          // },));
        }
      },
      builder: (context, state) {
        return (state is GetSnacksLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (state is GetMovieInfoLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title:
                          Text(MainPageCubit.get(context).movieInfo!.nameMovie),
                      actions: [
                        IconButton(
                            onPressed: () {
                              MainPageCubit.get(context).deleteMovieTickets(
                                  ticketID: widget.ticket!.ticketId);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                    body: SizedBox(
                      width: 1.sw,
                      height: 1.sh,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image(
                              image: NetworkImage(
                                  MainPageCubit.get(context).movieInfo!.image),
                              width: 1.sw,
                              height: 0.2.sh,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height: 0.05.sh,
                            ),
                            Text(
                              MainPageCubit.get(context).movieInfo!.nameMovie,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 0.05.sh,
                            ),
                            Text(
                              MainPageCubit.get(context).movieInfo!.description,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 0.05.sh,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Hall: ${MainPageCubit.get(context).movieInfo!.hall}',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            (state is GetHallInfoLoading)
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "Available Seats: ${MainPageCubit.get(context).hallsModel!.seats}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                            Text(
                              "Date:    ${MainPageCubit.get(context).movieInfo!.time}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Price: ${MainPageCubit.get(context).movieInfo!.price} Per Ticket",
                              style: const TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 0.05.sh,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Select Day",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 0.05.sw,
                                ),
                                Expanded(
                                  child: DateTimePicker(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        gapPadding: 0,
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    initialValue: widget.ticket!.date,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 30)),
                                    calendarTitle: 'Select Date',
                                    dateLabelText: 'Date',
                                    onChanged: (val) {
                                      setState(() {
                                        date = val;
                                      });
                                      print("Amr");
                                    },
                                    validator: (val) {
                                      setState(() {
                                        date = val;
                                      });
                                      print(val);
                                      return null;
                                    },
                                    onSaved: (val) {
                                      print("Amr");
                                      setState(() {
                                        date = val;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Number of Tickets",
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (count <
                                            MainPageCubit.get(context)
                                                .hallsModel!
                                                .seats) {
                                          count++;
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                                Text(
                                  "$count",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (count > 1) {
                                          setState(() {
                                            count--;
                                          });
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 0.05.sh,
                            ),
                          ],
                        ),
                      ),
                    ),
                    bottomSheet: (state is BookTicketLoading)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            width: 1.sw,
                            height: 0.1.sh,
                            color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Total Price: ${MainPageCubit.get(context).movieInfo!.price * count} \$",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (date == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Please Select Date")));
                                      } else {
                                        MainPageCubit.get(context).editTicket(
                                          date: date!,
                                          quantity: count,
                                          ticketID: widget.ticket!.ticketId,
                                          totalPrice: count *
                                              MainPageCubit.get(context)
                                                  .movieInfo!
                                                  .price,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            )),
                  );
      },
    );
  }
}
