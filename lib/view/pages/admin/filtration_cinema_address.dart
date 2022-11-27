import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/model/cinema_owner_model/cinema_model.dart';
import 'package:movie_flutterr/model/cinema_owner_model/movie_model.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../../view_model/cubit/home page/home_page_cubit.dart';
import '../cinema_owner/MoviesScreen.dart';
import '../user/detiles_screen.dart';
import 'cinema_Info.dart';

class FiltrationCinemaAddress extends StatefulWidget {
  FiltrationCinemaAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<FiltrationCinemaAddress> createState() => _FiltrationCinemaAddressState();
}

class _FiltrationCinemaAddressState extends State<FiltrationCinemaAddress> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).getAllCinemaOwner();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  String name = '';
  List<CinemaModel> cinemaModel = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        return Scaffold(
            appBar: AppBar(
              title: const Text('Search Cinema address'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
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
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
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
                        .collection('Cinemas')
                        .snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState == ConnectionState.waiting)
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : Expanded(
                        child: ListView.builder(

                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              cinemaModel = [];
                              snapshots.data!.docs.forEach((element) {
                                cinemaModel.add(CinemaModel.fromMap(
                                    element.data() as Map<String, dynamic>));
                              });
                              if (name.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return CinemaInfo
                                        (
                                        cinemaID: cinemaModel[index].id,
                                      );

                                    },));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [

                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            cinemaModel[index]
                                                .name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.red),
                                          ),

                                          Text(
                                            "${cinemaModel[index].address.toString()}  ",
                                            style: TextStyle(fontSize: 24.sp , fontWeight: FontWeight.w900, color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (cinemaModel[index]
                                  .address
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(name.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return CinemaInfo
                                        (
                                        cinemaID: cinemaModel[index].id,
                                      );

                                    },));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            cinemaModel[index]
                                                .name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w900,
                                            color: Colors.red),
                                            ),

                                          Text(
                                            "${cinemaModel[index].address.toString()}  ",
                                            style: TextStyle(fontSize: 24.sp , fontWeight: FontWeight.w900, color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          // Column(
                                          //   mainAxisAlignment:
                                          //   MainAxisAlignment.spaceAround,
                                          //   children: [
                                          //     CustomButton(
                                          //       disable: true,
                                          //       color: Colors.red,
                                          //       radius: 0,
                                          //       size: const Size(200, 20),
                                          //       function: () {
                                          //         showDialog(
                                          //           context: context,
                                          //           builder: (context) {
                                          //             return AlertDialog(
                                          //               content: const Text(
                                          //                   "Are You Sure To Delete This Product"),
                                          //               actions: [
                                          //                 // TextButton(
                                          //                 //     onPressed: () {
                                          //                 //       PharmacyCubit.get(
                                          //                 //           context)
                                          //                 //           .deleteProduct(
                                          //                 //           id: PharmacyCubit.get(
                                          //                 //               context)
                                          //                 //               .cinemaModel[
                                          //                 //           index]
                                          //                 //               .id)
                                          //                 //           .then(
                                          //                 //               (value) {
                                          //                 //             Navigator.pop(
                                          //                 //                 context);
                                          //                 //           });
                                          //                 //     },
                                          //                 //     child:
                                          //                 //     Text("Sure")),
                                          //                 TextButton(
                                          //                     onPressed: () {
                                          //                       Navigator.pop(
                                          //                           context);
                                          //                     },
                                          //                     child:
                                          //                     Text("Cancel"))
                                          //               ],
                                          //             );
                                          //           },
                                          //         );
                                          //       },
                                          //       widget: SizedBox(
                                          //         height: 40.h,
                                          //         width: 200,
                                          //         child: Center(
                                          //             child: Text("Delete")),
                                          //       ),
                                          //     ),
                                          //     CustomButton(
                                          //       disable: true,
                                          //       radius: 0,
                                          //       color: Colors.blueAccent,
                                          //       size: const Size(200, 20),
                                          //       function: () {
                                          //         Navigator.push(context,
                                          //             MaterialPageRoute(
                                          //               builder: (context) {
                                          //                 return EditProductScreen(
                                          //                     index: index,
                                          //                     pharmacyCubit:
                                          //                     PharmacyCubit.get(
                                          //                         context));
                                          //               },
                                          //             ));
                                          //       },
                                          //       widget: SizedBox(
                                          //         height: 40.h,
                                          //         width: 200.w,
                                          //         child:
                                          //         Center(child: Text("Edit")),
                                          //       ),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
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
