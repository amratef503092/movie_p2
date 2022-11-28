import 'dart:io' as io;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:movie_flutterr/model/cinema_owner_model/movie_model.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';

import '../../../constants/constants.dart';
import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../components/custom_button.dart';


class EditMovie extends StatefulWidget {
  EditMovie({Key? key, this.movieModel}) : super(key: key);
  MovieModel ? movieModel;

  @override
  State<EditMovie> createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController seat = TextEditingController();

  TextEditingController description = TextEditingController();

  RegExp regExp = RegExp(r"^[0-9][3]$", caseSensitive: false);

  @override
  void initState() {
    // TODO: implement initState
    AuthCubit
        .get(context)
        .image = null;
    nameController.text = widget.movieModel!.nameMovie;
    description.text = widget.movieModel!.description;
    value = widget.movieModel!.hall;
    AuthCubit.get(context)
        .getHalls(cinemaID: AuthCubit
        .get(context)
        .userModel!
        .cinemaID);
    super.initState();
  }

  String? value;
  String ?from;
  String ? to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Halls'),
      ),
      body: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Edit ${widget.movieModel!.nameMovie} Movie",
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),

                      SizedBox(
                        height: 50.h,
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      CustomTextField(
                        controller: nameController,
                        fieldValidator: (String value) {
                          if (value
                              .trim()
                              .isEmpty || value == ' ') {
                            return 'This field is required';
                          }
                        },
                        hint: 'Name Movie',
                        iconData: Icons.perm_identity,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: description,
                        fieldValidator: (String value) {
                          if (value
                              .trim()
                              .isEmpty || value == '') {
                            return 'This field is required';
                          }
                        },
                        hint: 'description',
                        iconData: Icons.description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),


                      (state is GetHallsLoading) ? const Center(
                        child: CircularProgressIndicator(),) : SizedBox(
                        child: Row(
                          children: [
                            const Text(
                              'Select Hall',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: const Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  items: AuthCubit
                                      .get(context)
                                      .halls
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item.name,
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ))
                                      .toList(),
                                  value: value,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: BACKGROUND_COLOR,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      this.value = value as String;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 140,
                                  itemHeight: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(children: [
                        Text("Movie is Expire ",
                          style: TextStyle(color: Colors.white),),
                        Switch(
                          value: widget.movieModel!.expire,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              widget.movieModel!.expire = value;
                            });
                          },
                          activeColor: RED_COLOR,
                          activeTrackColor: RED_COLOR,),
                      ],),
                      CustomButton(function: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              FromToTimePicker(
                                onTab: (from, to) {
                                  this.from = '${from.hour}:${to.minute}';
                                  this.to = '${to.hour}:${to.minute}';
                                  setState(() {
                                    widget.movieModel!.time =
                                    'from ${this.from} to ${this.to}';
                                  });
                                },
                                dialogBackgroundColor: Color(0xFF121212),
                                fromHeadlineColor: Colors.white,
                                toHeadlineColor: Colors.white,
                                upIconColor: Colors.white,
                                downIconColor: Colors.white,
                                timeBoxColor: Color(0xFF1E1E1E),
                                timeHintColor: Colors.grey,
                                timeTextColor: Colors.white,
                                dividerColor: Color(0xFF121212),
                                doneTextColor: Colors.white,
                                dismissTextColor: Colors.white,
                                defaultDayNightColor: Color(0xFF1E1E1E),
                                defaultDayNightTextColor: Colors.white,
                                colonColor: Colors.white,
                                showHeaderBullet: true,
                                headerText: 'Time available from 01:00 AM to 11:00 PM',
                              ),
                        );
                      }, widget: Text("current time is ${widget.movieModel!
                          .time}"), disable: true,),

                      SizedBox(
                        height: 50.h,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is EditFilmError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Error'),
                              ),
                            );
                          } else if (state is EditFilmSuccessful) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Edit Film Successful'),
                              ),
                            );
                            AuthCubit.get(context).getMovies(
                                cinemaID:
                                AuthCubit
                                    .get(context)
                                    .userModel!
                                    .cinemaID);
                            nameController.clear();
                            description.clear();
                            AuthCubit
                                .get(context)
                                .image = null;
                            Navigator.maybePop(context);
                          }
                        },
                        builder: (context, state) {
                          return (state is EditFilmLoading)
                              ? const Center(
                            child: CircularProgressIndicator(),
                          )
                              : CustomButton(
                              disable: true,
                              widget: const Text("Edit Movie"),
                              function: () {
                                if (value == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Please Select Hall'),
                                    ),
                                  );
                                } else if (from == null || to == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Please Select Time'),
                                    ),
                                  );
                                }

                                if (formKey.currentState!.validate() ) {
                                  AuthCubit.get(context)
                                      .editFilm(
                                    movieModel: widget.movieModel!,
                                  );
                                }
                              });
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // BlocProvider(
                      //   create: (context) => SignupCubit(),
                      //   child: BlocConsumer<SignupCubit, SignupState>(
                      //     listener: (context, state) {
                      //       if(state is CreateCinemasSuccessful){
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text('Create New Cinema Done'),
                      //             backgroundColor: Colors.green,
                      //           ),
                      //         );
                      //         Navigator.pushAndRemoveUntil(
                      //             context, MaterialPageRoute(builder: (context) {
                      //           return const CinemaOwnerLayout();
                      //         },), (route) => false);
                      //
                      //       }
                      //       // TODO: implement listener
                      //     },
                      //     builder: (context, state) {
                      //       return (state is CreateCinemasLoading)?
                      //       const Center(child: CircularProgressIndicator(),):CustomButton(
                      //         function: () {
                      //           if (formKey.currentState!.validate()) {
                      //             SignupCubit.get(context).createCinema(
                      //               description:description.text.trim(),
                      //               address: addressController.text.trim(),
                      //               name: nameController.text.trim(),
                      //               open: timeRangeResult!.start.toString(),
                      //               close: timeRangeResult!.start.toString(),
                      //               numberOfHalls: 0,
                      //               numberOfminiShops: 0,
                      //             ).then((value) {
                      //
                      //             });
                      //           }
                      //         },
                      //         widget: Text("Register"),
                      //         size: Size(300.w, 50.h),
                      //         radius: 20.r,
                      //         color: RED_COLOR,
                      //         disable: true,
                      //       );
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
