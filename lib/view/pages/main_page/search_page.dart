import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/model/cinema_owner_model/movie_model.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view/components/search/serach_card.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/search/search_cubit.dart';

import '../../../view_model/cubit/home page/home_page_cubit.dart';
import '../cinema_owner/MoviesScreen.dart';
import '../user/detiles_screen.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.movies}) : super(key: key);

  List<Movie> movies;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  String name = '';

  List<MovieModel> movieModel = [];

  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        HomePageCubit myCubit = HomePageCubit.get(context);

        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h,),
                  TextFormField
                    (

                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                      prefixIcon: const Icon(Icons.search , color: Colors.white,),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Movie')
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState == ConnectionState.waiting)
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Expanded(
                        child: GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              movieModel = [];
                              snapshots.data!.docs.forEach((element) {
                                movieModel.add(MovieModel.fromMap(
                                    element.data() as Map<String, dynamic>));
                              });
                              if (name.isEmpty) {
                                return CustomCardMovie(
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: myCubit,
                                                  child: DetailsMovieScreen(
                                                    movie: MainPageCubit.get(
                                                        context)
                                                        .movies[index],
                                                  ),
                                                )));
                                  },
                                  title: MainPageCubit.get(context)
                                      .movies[index]
                                      .nameMovie,
                                  image: MainPageCubit.get(context)
                                      .movies[index]
                                      .image,
                                );
                              }
                              if (movieModel[index]
                                  .nameMovie
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return CustomCardMovie(
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: myCubit,
                                                  child: DetailsMovieScreen(
                                                    movie: MainPageCubit.get(
                                                        context)
                                                        .movies[index],
                                                  ),
                                                )));
                                  },
                                  title: MainPageCubit.get(context)
                                      .movies[index]
                                      .nameMovie,
                                  image: MainPageCubit.get(context)
                                      .movies[index]
                                      .image,
                                );
                              }
                              return Container();
                            }),
                      );
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }
}
