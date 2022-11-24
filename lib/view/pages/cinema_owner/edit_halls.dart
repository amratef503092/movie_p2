import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/model/cinema_owner_model/halls_model.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../components/custom_button.dart';

class EditHalls extends StatefulWidget {
  EditHalls({Key? key, required this.hallsModel}) : super(key: key);
  HallsModel hallsModel;

  @override
  State<EditHalls> createState() => _EditHallsState();
}

class _EditHallsState extends State<EditHalls> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController seat = TextEditingController();

  TextEditingController description = TextEditingController();

  RegExp regExp = RegExp(r"^[0-9][3]$", caseSensitive: false);

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.hallsModel.name;
    seat.text = widget.hallsModel.seats.toString();
    description.text = widget.hallsModel.description;
    super.initState();
  }

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/logo.png'),
                    height: 100.h,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  const Text(
                    "Edit Your Halls",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextField(
                    controller: nameController,
                    fieldValidator: (String value) {
                      if (value.trim().isEmpty || value == ' ') {
                        return 'This field is required';
                      }
                      if (!RegExp(r'^[a-zA-Z]+(\s[a-zA-Z]+)?$')
                          .hasMatch(value)) {
                        return 'please enter only two names with one space';
                      }
                      if (value.length < 3 || value.length > 32) {
                        return 'First name must be between 2 and 32 characters';
                      }
                    },
                    hint: 'name',
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
                    controller: seat,
                    textInputType: TextInputType.number,
                    fieldValidator: (String value) {
                      if (value.isEmpty) {
                        return "Number Of Seat is required";
                      }
                    },
                    hint: 'Number Of Seats',
                    iconData: Icons.event_seat,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is CreateHallsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      } else if (state is EditHallsSuccessful) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Create Halls Successful'),
                          ),
                        );
                        AuthCubit.get(context).getHalls(
                            cinemaID:
                                AuthCubit.get(context).userModel!.cinemaID);
                        Navigator.maybePop(context);
                      }
                    },
                    builder: (context, state) {
                      return (state is EditHallsLoading)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              disable: true,
                              widget: const Text("Edit Halls"),
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).editHalls(
                                      name: nameController.text.trim(),
                                      description: description.text.trim(),
                                      seat: int.parse(seat.text),
                                      cinemaID: AuthCubit.get(context)
                                          .userModel!
                                          .cinemaID);
                                }
                              });
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is CreateHallsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      } else if (state is EditHallsSuccessful) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Create Halls Successful'),
                          ),
                        );
                        AuthCubit.get(context).getHalls(
                            cinemaID:
                                AuthCubit.get(context).userModel!.cinemaID);
                        Navigator.maybePop(context);
                      }
                    },
                    builder: (context, state) {
                      return (state is EditHallsLoading)
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              disable: true,
                              widget: const Text("Delete Halls"),
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).deleteHalls(
                                    name: nameController.text.trim(),
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
          ),
        ),
      ),
    );
  }
}
