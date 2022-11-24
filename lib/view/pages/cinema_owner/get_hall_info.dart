import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/MoviesScreen.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

class GetHallInfo extends StatefulWidget {
  GetHallInfo({Key? key, required this.hallName, required this.cinemaID})
      : super(key: key);
  String hallName;
  String cinemaID;

  @override
  State<GetHallInfo> createState() => _GetHallInfoState();
}

class _GetHallInfoState extends State<GetHallInfo> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context)
        .getHallInfo(cinemaID: widget.cinemaID, hallName: widget.hallName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hallName),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return GridView.builder(
                    itemCount: AuthCubit.get(context).hallInfo.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return CustomCardMovie(
                        function: () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context){
                          //   return EditMovie(movieModel: AuthCubit.get(context).movies[index],);
                          // }));
                        },
                        image: AuthCubit.get(context).hallInfo[index].image,
                        title: AuthCubit.get(context).hallInfo[index].nameMovie,
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
