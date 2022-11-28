import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/model/cinema_owner_model/movie_model.dart';
import 'package:movie_flutterr/view/components/user_info.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';


class MovieScreenInfo extends StatefulWidget {
  MovieScreenInfo({Key? key, required this.movie}) : super(key: key);
  MovieModel movie;

  @override
  State<MovieScreenInfo> createState() => _MovieScreenInfoState();
}

class _MovieScreenInfoState extends State<MovieScreenInfo> {
  @override
  void initState() {
    MainPageCubit.get(context).getHellInfo(hallName: widget.movie.hall);
    MainPageCubit.get(context).getSnacks(cinemaID: widget.movie.cinemaID);
    // TODO: implement initState
    super.initState();
  }

  int count = 1;
  int priceAllSnacks = 0;
  String? date;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is BookTicketSuccess){
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
            : Scaffold(
          appBar: AppBar(
            title: Text(widget.movie.nameMovie),
          ),
          body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(widget.movie.image),
                    width: 1.sw,
                    height: 0.2.sh,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  Text(
                    widget.movie.nameMovie,
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  Text(
                    widget.movie.description,
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
                        'Hall: ${widget.movie.hall}',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  (state is GetHallInfoLoading)?const
                  Center(child: CircularProgressIndicator(),):
                  Text(
                    "Available Seats: ${MainPageCubit.get(context).hallsModel!.seats}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Date:    ${widget.movie.time}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Price: ${widget.movie.price} Per Ticket",
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Text(
                  //       "Select Day",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     SizedBox(
                  //       width: 0.05.sw,
                  //     ),
                  //     Expanded(
                  //       child: DateTimePicker(
                  //         decoration: InputDecoration(
                  //           border: OutlineInputBorder(
                  //             gapPadding: 0,
                  //             borderRadius: BorderRadius.circular(10),
                  //             borderSide: BorderSide(
                  //               color: Colors.red,
                  //             ),
                  //           ),
                  //         ),
                  //         style: const TextStyle(color: Colors.white),
                  //         initialValue: 'Enter Date',
                  //         firstDate: DateTime.now(),
                  //         lastDate: DateTime.now()
                  //             .add(const Duration(days: 30)),
                  //         calendarTitle: 'Select Date',
                  //         dateLabelText: 'Date',
                  //         onChanged: (val) {
                  //           setState(() {
                  //             date = val;
                  //           });
                  //           print("Amr");
                  //         },
                  //         validator: (val) {
                  //           setState(() {
                  //             date = val;
                  //           });
                  //           print(val);
                  //           return null;
                  //         },
                  //         onSaved: (val) {
                  //           print("Amr");
                  //           setState(() {
                  //             date = val;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Number of Tickets",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //     IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             if (count <
                  //                 MainPageCubit.get(context)
                  //                     .hallsModel!
                  //                     .seats) {
                  //               count++;
                  //             }
                  //           });
                  //         },
                  //         icon: const Icon(
                  //           Icons.add,
                  //           color: Colors.white,
                  //         )),
                  //     Text(
                  //       "$count",
                  //       style: const TextStyle(color: Colors.white),
                  //     ),
                  //     IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             if (count > 1) {
                  //               setState(() {
                  //                 count--;
                  //               });
                  //             }
                  //           });
                  //         },
                  //         icon: const Icon(
                  //           Icons.remove,
                  //           color: Colors.white,
                  //         )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 0.05.sh,
                  // ),
                ],
              ),
            ),
          ),
          // bottomSheet: (state is BookTicketLoading)?Center(child: CircularProgressIndicator(),):Container(
          //     width: 1.sw,
          //     height: 0.1.sh,
          //     color: Colors.red,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         Text(
          //           "Total Price: ${widget.movie.price * count} \$",
          //           style: const TextStyle(color: Colors.white),
          //         ),
          //         ElevatedButton(
          //             onPressed: () {
          //               if (date == null) {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                     const SnackBar(
          //                         content: Text("Please Select Date")));
          //               } else  {
          //                 MainPageCubit.get(context).bookTicket(
          //                   movieName: widget.movie.nameMovie,
          //                   hallName: widget.movie.hall,
          //                   time: widget.movie.time,
          //                   date: date!,
          //                   quantity: count,
          //                   totalPrice: count * widget.movie.price,
          //                   price: widget.movie.price,
          //                   cinemaId: widget.movie.cinemaID,
          //                   movieId: widget.movie.id,
          //                   userId:
          //                   FirebaseAuth.instance.currentUser!.uid,
          //                 );
          //               }
          //             },
          //             child: const Text(
          //               "Book",
          //               style: TextStyle(color: Colors.white),
          //             ))
          //       ],
          //     )),
        );
      },
    );
  }
}
