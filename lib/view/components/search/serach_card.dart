import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/pages/movie_page.dart';

class SearchCard extends StatelessWidget {
  SearchCard({Key? key, required this.movie})
      : super(key: key);

  Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePage(movie: movie),));
      },
      child: Card(
        color: TEXT_FIELD_BACKGROUND_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: SizedBox(
          height: 80.h,
          child: Row(
            children: [
              Container(
                height: 80.h,
                width: 50.w,
                decoration: BoxDecoration(
                    image: DecorationImage(image: movie.image! ,fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r))),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Text(
                  movie.name!,
                  style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
