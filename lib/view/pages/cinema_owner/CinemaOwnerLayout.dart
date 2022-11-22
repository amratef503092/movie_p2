import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_flutterr/view_model/cubit/layout_cinema_owner_cubit/layout_cinema_owner_cubit.dart';

class CinemaOwnerLayout extends StatefulWidget {
  const CinemaOwnerLayout({Key? key}) : super(key: key);

  @override
  State<CinemaOwnerLayout> createState() => _CinemaOwnerLayoutState();
}

class _CinemaOwnerLayoutState extends State<CinemaOwnerLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCinemaOwnerCubit(),
      child: BlocConsumer<LayoutCinemaOwnerCubit, LayoutCinemaOwnerState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              body: LayoutCinemaOwnerCubit.get(context)
                  .screens[LayoutCinemaOwnerCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.home),
                    label: 'Halls',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.movie),
                    label: 'Movies',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.ticketAlt),
                    label: 'Tickets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user),
                    label: 'Profile',
                  ),
                ],
                currentIndex: LayoutCinemaOwnerCubit.get(context).currentIndex,
                onTap: (index) {
                  LayoutCinemaOwnerCubit.get(context).changeIndex(index);
                },
              ));
        },
      ),
    );
  }
}
