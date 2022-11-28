import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_flutterr/view/pages/admin/settings_screen.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../../view_model/cubit/layout_admin/layout_admin_cubit.dart';
import '../../../view_model/database/local/cache_helper.dart';
import '../auth/login_page.dart';
import 'create_admin.dart';
import 'create_cinema_owner.dart';
import 'filteration_by_film_name.dart';
import 'filtration_cinema_address.dart';

class LayOutScreenAdmin extends StatefulWidget {
  const LayOutScreenAdmin({Key? key}) : super(key: key);

  @override
  State<LayOutScreenAdmin> createState() => _LayOutScreenAdminState();
}

class _LayOutScreenAdminState extends State<LayOutScreenAdmin> {
  @override
  void initState() {
    AuthCubit.get(context).getUserData();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutAdminCubit(),
      child: BlocConsumer<LayoutAdminCubit, LayoutAdminState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LayoutAdminCubit.get(context)
                  .appbarTitle[LayoutAdminCubit.get(context).currentIndex]),
              centerTitle: true,
            ),
            drawer: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return (state is GetUserDataLoadingState)
                    ? const CircularProgressIndicator()
                    : Drawer(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            CircleAvatar(
                              radius: 80.r,
                              backgroundImage: NetworkImage(
                                  AuthCubit.get(context).userModel!.photo),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            ListTile(
                              leading: const Icon(Icons.perm_identity),
                              title: const Text("Create Admin"),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const CreateAdmin();
                                  },
                                ));
                              },
                            ),
                            // ListTile(
                            //   leading: const Icon(Icons.work),
                            //   title: const Text("Approve Pharmacy"),
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => const ApproveScreen(),
                            //         ));
                            //   },
                            // ),
                            ListTile(
                              leading: const Icon(Icons.settings),
                              title: const Text("Settings"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen(),
                                    ));
                              },
                            ),
                            // ListTile(
                            //   leading: const Icon(Icons.shopify),
                            //   title: const Text("Product"),
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => const AdminShowProduct(),
                            //         ));
                            //   },
                            // ),

                            ListTile(
                              leading: const Icon(FontAwesomeIcons.film),
                              title: const Text("Create Cinema Owner"),
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const CreateCinemaOwner();
                                  },
                                ));
                              },
                            ),
                            ListTile(
                              leading: const Icon(FontAwesomeIcons.search),
                              title: const Text("Filtration By FilmName"),
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return FiltartionByFilmName();
                                  },
                                ));
                              },
                            ),
                            ListTile(
                              leading: const Icon(FontAwesomeIcons.search),
                              title: const Text("Filtration By address"),
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return FiltrationCinemaAddress();
                                  },
                                ));
                              },
                            ),

                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text("Logout"),
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(CacheHelper.get(key: 'id'))
                                    .update({
                                  'online': false,
                                }).then((value) async {
                                  await FirebaseAuth.instance.signOut();
                                }).then((value) async {
                                  await CacheHelper.removeData(key: 'id');
                                  await CacheHelper.removeData(key: 'role');
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                      (route) => false);
                                });
                              },
                            ),
                          ],
                        ),
                      );
              },
            ),
            body: LayoutAdminCubit.get(context)
                .screens[LayoutAdminCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: LayoutAdminCubit.get(context).currentIndex,
              onTap: (index) {
                LayoutAdminCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Cinema Owner',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Customer',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
