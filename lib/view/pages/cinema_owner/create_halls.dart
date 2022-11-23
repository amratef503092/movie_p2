import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/view/components/custom_button.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view_model/cubit/layout_cinema_owner_cubit/layout_cinema_owner_cubit.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';

class CreateHalles extends StatefulWidget {
  const CreateHalles({Key? key}) : super(key: key);

  @override
  State<CreateHalles> createState() => _CreateHallesState();
}

class _CreateHallesState extends State<CreateHalles> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController seat = TextEditingController();
  TextEditingController description = TextEditingController();
  RegExp regExp = RegExp(r"^[0-9][3]$", caseSensitive: false);

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
                    "Create Your Halls",
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
                  BlocConsumer<LayoutCinemaOwnerCubit, LayoutCinemaOwnerState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if(state is CreateHallsError){
                        ScaffoldMessenger.of(context).showSnackBar(

                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                          ),
                        );
                      }else if(state is CreateHallsSuccessful){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(backgroundColor: Colors.green,
                            content: Text('Create Halls Successful'),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return (state is CreateHallsLoading )?Center(child: CircularProgressIndicator(),):CustomButton(
                          disable: true,
                          widget: Text("Create Halls"),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              LayoutCinemaOwnerCubit.get(context).createHalls(
                              name: nameController.text.trim(),
                              description: description.text.trim(),
                              seat: int.parse(seat.text),
                                cinemaID: AuthCubit.get(context).userModel!.cinemaID,
                            )
                                ;
                            }
                          });
                    },
                  ),

                  SizedBox(
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
