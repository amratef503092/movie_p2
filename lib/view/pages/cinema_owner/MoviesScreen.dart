import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/view/components/custom_button.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/modefiy_Movie.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import 'add_movie.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context)
        .getMovies(cinemaID: AuthCubit.get(context).userModel!.cinemaID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies Screen"),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                disable: true,
                widget: const Text("ADD New Movie"),
                function: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const AddMovie();
                    },
                  ));
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return (state is GetFilmsLoading)?Center(child: CircularProgressIndicator(),):Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GridView.builder(
                        itemCount: AuthCubit.get(context).movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return CustomCardMovie(
                            function: ()
                            {
                              Navigator.push(context,MaterialPageRoute(builder: (context){
                                return EditMovie(movieModel: AuthCubit.get(context).movies[index],);
                              }));
                            },
                            image:
                            AuthCubit.get(context).movies[index].image,
                            title:  AuthCubit.get(context).movies[index].nameMovie,
                          );
                        }),
                  ));
                },
              )
            ],
          ),
        ));
  }
}

class CustomCardMovie extends StatelessWidget {
  const CustomCardMovie({
    required this.image,
    required this.title,
    required this.function,
    Key? key,
  }) : super(key: key);
  final String image;
  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 17),
              blurRadius: 23,
              spreadRadius: -13,
              color: Colors.black,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
    );
  }
}
