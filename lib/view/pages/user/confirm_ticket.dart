import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'buy_snacks.dart';

class ConfirmTicket extends StatefulWidget {
  ConfirmTicket({
    Key? key,
    required this.totalPrice,
    required this.cinemaID,
    required this.time,
    required this.hallName,
    required this.date,
    required this.movieName,
    required this.ticketId,

  }) : super(key: key);
  String ticketId;
  String movieName;
  String hallName;
  String date;
  String time;
  int totalPrice;
  String cinemaID ;

  @override
  State<ConfirmTicket> createState() => _ConfirmTicketState();
}

class _ConfirmTicketState extends State<ConfirmTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Ticket'),
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.checkCircle,
              color: Colors.green,
              size: 100.sp,
            ),
            Text(
              'Movie Name : ${widget.movieName}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Hall Name : ${widget.hallName}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Date : ${widget.date}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Time : ${widget.time}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Total Price : ${widget.totalPrice}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Ticket Id : ${widget.ticketId}',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BuySnacks(
                            ticketId: widget.ticketId,
                        cinemaID: widget.cinemaID,
                          )));
                },
                child: Text('Buy Snacks')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back'))
          ],
        ),
      ),
    );
  }
}
