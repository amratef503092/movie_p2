import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/cinema_owner_model/movie_model.dart';

import 'book_screen.dart';

class DetailsMovieScreen extends StatefulWidget {
  DetailsMovieScreen({Key? key, required this.movie}) : super(key: key);
  MovieModel? movie;

  @override
  State<DetailsMovieScreen> createState() => _DetailsMovieScreenState();
}

class _DetailsMovieScreenState extends State<DetailsMovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie!.nameMovie),
      ),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          children: [
            Image(
              image: NetworkImage(widget.movie!.image),
              width: 1.sw,
              height: 0.5.sh,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 0.05.sh,
            ),
            Text(
              widget.movie!.nameMovie,
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 0.05.sh,
            ),
            Text(
              widget.movie!.description,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          width: 1.sw,
          height: 0.1.sh,
          color: RED_COLOR,
          child: InkWell(
            onTap: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookScreen(movie: widget.movie!,)));
            },
            child: Center(
              child: Text(
                "Book Now",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          )),
    );
  }
}
