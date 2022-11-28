import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_flutterr/view/pages/admin/show_snak.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/MoviesScreen.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import '../../components/custom_data_empty.dart';
import 'movie_info.dart';

class CinemaInfo extends StatefulWidget {
  CinemaInfo({Key? key, required this.cinemaID}) : super(key: key);
  String cinemaID;

  @override
  State<CinemaInfo> createState() => _CinemaInfoState();
}

class _CinemaInfoState extends State<CinemaInfo> {
  @override
  void initState() {
    print(widget.cinemaID);
    // TODO: implement initState
    AuthCubit.get(context).getMovies(cinemaID: widget.cinemaID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cinema Info'), actions: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.cookie),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ShowSnack(
                  cinemaId: widget.cinemaID,
                );
              },
            ));
          },
        ),
      ]),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return (AuthCubit.get(context).movies.isEmpty)?
          const DataEmptyWidget():
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: AuthCubit.get(context).movies.length,
                itemBuilder: (context, index) {
                  return CustomCardMovie(
                      image: AuthCubit.get(context).movies[index].image,
                      title: AuthCubit.get(context).movies[index].nameMovie,
                      function: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MovieScreenInfo(
                              movie: AuthCubit.get(context).movies[index],
                            );
                          },
                        ));
                      });
                }),
          );
        },
      ),
    );
  }
}
