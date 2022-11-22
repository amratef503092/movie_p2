import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:time_range/time_range.dart';

import '../../../constants/constants.dart';
import '../../../constants/validator.dart';
import '../../../view_model/cubit/signup/signup_cubit.dart';
import '../../components/custom_button.dart';
import 'CinemaOwnerLayout.dart';
class CreateCinema extends StatefulWidget {
  const CreateCinema({Key? key}) : super(key: key);

  @override
  State<CreateCinema> createState() => _CreateCinemaState();
}

class _CreateCinemaState extends State<CreateCinema> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController open = TextEditingController();
  TextEditingController end = TextEditingController();


  bool showPassword = false;
  List<String> gender = ['Male', 'Female'];
  String? valueGender;
  RegExp regExp = RegExp(r"^[0-9]{2}$", caseSensitive: false);
  TimeRangeResult ? timeRangeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Create Your Cinema",
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
                    controller: addressController,
                    fieldValidator: (String value) {
                     if(value.isEmpty){
                        return 'This field is required';
                     }
                    },
                    hint: 'Address',
                    iconData: FontAwesomeIcons.locationDot,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: description,
                    fieldValidator: (String value) {
                      if (value.trim().isEmpty || value == ' ') {
                        return 'This field is required';
                      }
                    },
                    hint: 'description',
                    iconData: Icons.description,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TimeRange(
                    fromTitle: const Text('From', style: TextStyle(fontSize: 18, color: Colors.white),),
                    toTitle: const Text('To', style: TextStyle(fontSize: 18, color: Colors.white),),
                    titlePadding: 20,
                    textStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
                    activeTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    borderColor: RED_COLOR,
                    backgroundColor: Colors.transparent,
                    activeBackgroundColor: RED_COLOR,
                    firstTime: const TimeOfDay(hour: 14, minute: 30),
                    lastTime: const TimeOfDay(hour: 20, minute: 00),
                    timeStep: 10,
                    timeBlock: 30,
                    onRangeCompleted: (range) => setState(() {
                      timeRangeResult = range;
                      print(timeRangeResult!.start);
                    } ),
                  ),


                  // creat drop down button

                  SizedBox(
                    height: 20,
                  ),
                  BlocProvider(
                    create: (context) => SignupCubit(),
                    child: BlocConsumer<SignupCubit, SignupState>(
                      listener: (context, state) {
                        if(state is CreateCinemasSuccessful){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Create New Cinema Done'),
                              backgroundColor: Colors.green,
                            ),
                          );
                         Navigator.pushAndRemoveUntil(
                             context, MaterialPageRoute(builder: (context) {
                           return const CinemaOwnerLayout();
                         },), (route) => false);

                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return (state is CreateCinemasLoading)?
                        const Center(child: CircularProgressIndicator(),):CustomButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              SignupCubit.get(context).createCinema(
                             description:description.text.trim(),
                                address: addressController.text.trim(),
                                name: nameController.text.trim(),
                                open: timeRangeResult!.start.toString(),
                                close: timeRangeResult!.start.toString(),
                                numberOfHalls: 0,
                                numberOfminiShops: 0,
                              ).then((value) {

                              });
                            }
                          },
                          widget: Text("Register"),
                          size: Size(300.w, 50.h),
                          radius: 20.r,
                          color: RED_COLOR,
                          disable: true,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
