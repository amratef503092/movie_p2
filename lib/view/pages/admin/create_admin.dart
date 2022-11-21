import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view/pages/admin/home_admin_screen.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart' as auth;

import '../../../constants/constants.dart';
import '../../../constants/validator.dart';
import '../../../view_model/cubit/signup/signup_cubit.dart';
import '../../components/custom_button.dart';

class CreateAdmin extends StatefulWidget {
  const CreateAdmin({Key? key}) : super(key: key);

  @override
  State<CreateAdmin> createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  bool showPassword = false;
  List<String> gender = ['Male', 'Female'];
  String? valueGender;
  RegExp regExp = RegExp(r"^[0-9]{2}$", caseSensitive: false);

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
              padding: EdgeInsets.all(10),
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
                    "Create New Admin",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  CustomTextField(
                    controller: emailController,
                    fieldValidator: emailValidator,
                    hint: 'email',
                    iconData: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    fieldValidator: passwordValidator,
                    hint: 'Password',
                    iconData: Icons.lock,
                    password: showPassword,
                    passwordTwo: true,
                    function: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  SizedBox(
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
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.marsAndVenus,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      SizedBox(
                        width: 290.w,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: const Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            items: gender
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                            value: valueGender,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: BACKGROUND_COLOR,
                            ),
                            onChanged: (value) {
                              setState(() {
                                valueGender = value as String;
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textInputType: TextInputType.number,
                    controller: ageController,
                    fieldValidator: (String value) {
                      if (value.isEmpty) {
                        return "age is required";
                      } else if (regExp.hasMatch(value) == false) {
                        return "number only";
                      } else if (int.parse(value) < 0 &&
                          int.parse(value) < 100) {
                        return "please enter valid age";
                      }
                    },
                    hint: 'Age',
                    iconData: Icons.date_range,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  CustomTextField(
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                    fieldValidator: phoneValidator,
                    hint: 'phone',
                    iconData: Icons.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // creat drop down button

                  SizedBox(
                    height: 20,
                  ),
                  BlocProvider(
                    create: (context) => SignupCubit(),
                    child: BlocConsumer<SignupCubit, SignupState>(
                      listener: (context, state) {
                        if(state is RegisterSuccessfulState){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Create New Admin Done'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          auth.AuthCubit.get(context).getAdmin();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeAdminScreen()));
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return (state is RegisterLoadingState)?const Center(child: CircularProgressIndicator(),):CustomButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              SignupCubit.get(context).registerUser(
                                  gender: valueGender.toString(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  username: nameController.text,
                                  role: '1',
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
