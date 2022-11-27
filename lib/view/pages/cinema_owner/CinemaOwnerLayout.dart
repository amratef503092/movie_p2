import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:movie_flutterr/view_model/cubit/layout_cinema_owner_cubit/layout_cinema_owner_cubit.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';

class CinemaOwnerLayout extends StatefulWidget {
  const CinemaOwnerLayout({Key? key}) : super(key: key);

  @override
  State<CinemaOwnerLayout> createState() => _CinemaOwnerLayoutState();
}

class _CinemaOwnerLayoutState extends State<CinemaOwnerLayout> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).getUserData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCinemaOwnerCubit, LayoutCinemaOwnerState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LayoutCinemaChangLoading,
          child: Scaffold(
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
                    icon: Icon(FontAwesomeIcons.shop),
                    label: 'Main Shops',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: 'chat'),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user),
                    label: 'Profile',
                  ),
                ],
                currentIndex: LayoutCinemaOwnerCubit.get(context).currentIndex,
                onTap: (index) {
                  LayoutCinemaOwnerCubit.get(context).changeIndex(index);
                },
              )),
        );
      },
    );
  }
}
