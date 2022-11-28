import 'dart:io' as io;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../constants/constants.dart';
import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../components/custom_button.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key? key}) : super(key: key);

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController seat = TextEditingController();

  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  RegExp regExp = RegExp(r"^[0-9][3]$", caseSensitive: false);

  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).image = null;
    AuthCubit.get(context)
        .getHalls(cinemaID: AuthCubit.get(context).userModel!.cinemaID);
    super.initState();
  }

  String? value;
  String? from;
  String? to;
  TimeRange? _timeRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Halls'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is AddNewFilmSuccessful) {
                AuthCubit.get(context).getMovies(
                    cinemaID: AuthCubit.get(context).userModel!.cinemaID);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Add New Movie",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),

                      AuthCubit.get(context).image == null
                          ? const Text(
                              "Select Image Please",
                              style: TextStyle(color: Colors.white),
                            )
                          : Image(
                              image: FileImage(
                                io.File(AuthCubit.get(context).image!.path),
                              ),
                            ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomButton(
                          widget: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.camera_alt),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Choose Cover'),
                            ],
                          ),
                          function: () {
                            AuthCubit.get(context).pickImageMovie(context);
                          },
                          disable: true),
                      SizedBox(
                        height: 50.h,
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      CustomTextField(
                        controller: nameController,
                        fieldValidator: (String value) {
                          if (value.trim().isEmpty || value == ' ') {
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
                          if (value.trim().isEmpty || value == '') {
                            return 'This field is required';
                          }
                        },
                        hint: 'description',
                        iconData: Icons.description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      CustomTextField(
                        controller: price,
                        fieldValidator: (String value) {
                          if (value.trim().isEmpty || value == '') {
                            return 'This field is required';
                          }
                        },
                        hint: 'price',
                        textInputType: TextInputType.number,
                        iconData: Icons.price_change,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (state is GetHallsLoading)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
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
                                        items: AuthCubit.get(context)
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
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                      CustomButton(
                        function: () async {
                          if (_timeRange != null) {
                            _timeRange = await showTimeRangePicker(
                              end: _timeRange!.endTime,
                              start: _timeRange!.startTime,
                              onStartChange: (value) {
                                print(value);
                              },
                              context: context,
                            );
                          } else {
                            _timeRange = await showTimeRangePicker(
                              onStartChange: (value) {
                                print(value);
                              },
                              context: context,
                            );
                          }

                          setState(() {
                            from = _timeRange!.startTime.format(context);
                            to = _timeRange!.endTime.format(context);
                          });
                        },
                        widget: (_timeRange != null)
                            ? Text("From : " +
                                from.toString() +
                                " To " +
                                to.toString())
                            : const Text('Select time'),
                        disable: true,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is AddNewFilmError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Error'),
                              ),
                            );
                          } else if (state is AddNewFilmSuccessful) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Create Halls Successful'),
                              ),
                            );
                            AuthCubit.get(context).getHalls(
                                cinemaID:
                                    AuthCubit.get(context).userModel!.cinemaID);
                            nameController.clear();
                            description.clear();
                            AuthCubit.get(context).image = null;
                            Navigator.maybePop(context);
                          }
                        },
                        builder: (context, state) {
                          return (state is CreateHallsLoading)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomButton(
                                  disable: true,
                                  widget: const Text("Add Movie"),
                                  function: () {
                                    if (value == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Please Select Hall'),
                                        ),
                                      );
                                    } else if (from == null || to == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Please Select Time'),
                                        ),
                                      );
                                    }

                                    if (formKey.currentState!.validate() &&
                                        AuthCubit.get(context).image != null &&
                                        to != null &&
                                        from != null) {
                                      AuthCubit.get(context).addNewMovie(
                                          time: 'from $from to $to',
                                          price: int.parse(price.text),
                                          nameMovie: nameController.text.trim(),
                                          description: description.text.trim(),
                                          hall: value!,
                                          cinemaID: AuthCubit.get(context)
                                              .userModel!
                                              .cinemaID,
                                          context: context);
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
