import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/pages/movie_page.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UpComingMovieCard extends StatelessWidget {
  UpComingMovieCard({Key? key, required this.movie}) : super(key: key);

  Movie movie;

  //VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    /*controller = VideoPlayerController.network(trailer);*/
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoviePage(movie: movie),
                ));
          },
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r)),
            child: SizedBox(
              width: 290,
              height: 190,
              child: Stack(
                children: [
                  /*AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: VideoPlayer(controller!),
                  ),*/
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            image: DecorationImage(
                                image: movie.image!, fit: BoxFit.cover)),
                      )),
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: BACKGROUND_COLOR,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              BACKGROUND_COLOR,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                            ]),
                        borderRadius: BorderRadius.circular(5.r)),
                  ),
                  Positioned(
                      bottom: 20.h,
                      left: 15.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.name!,
                            style: GoogleFonts.roboto(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Opacity(
                            opacity: 0.67,
                            child: Text(
                              "April 1 2022",
                              style: GoogleFonts.roboto(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
