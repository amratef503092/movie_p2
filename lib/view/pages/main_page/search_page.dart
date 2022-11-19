import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/model/movies/movie_model.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view/components/search/serach_card.dart';
import 'package:movie_flutterr/view_model/cubit/search/search_cubit.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key, required this.movies}) : super(key: key);

  List<Movie> movies;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          SearchCubit myCubit = SearchCubit.get(context);
          return Center(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 35.h),
                    width: 360.w,
                    height: 80.h,
                    child: Text(
                      "Search",
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  height: 36.h,
                ),
                CustomTextField(
                    onChange: (value) {
                      myCubit.searchTextChanged(value);
                    },
                    borderRadius: 40,
                    controller: searchController,
                    hintText: "Search"),
                SizedBox(
                  height: 36.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.w,
                    ),
                    child: ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return myCubit.showMovieInList(movies[index].name!)
                            ? SearchCard(
                               movie: movies[index],)
                            : SizedBox();
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
