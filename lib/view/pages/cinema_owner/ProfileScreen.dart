import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../constants/constants.dart';
import '../../../constants/validator.dart';
import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../../view_model/cubit/layout_cinema_owner_cubit/layout_cinema_owner_cubit.dart';
import '../../../view_model/database/local/cache_helper.dart';
import '../../components/custom_button.dart';
import '../../components/custom_textfield.dart';
import '../auth/login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  bool showPassword = false;
  bool enable = false;
  String? value;
  String? from;
  String? to;
  @override
  void initState() {
    // TODO: implement initState
    nameController.text = AuthCubit.get(context).userModel!.name;
    phoneController.text = AuthCubit.get(context).userModel!.phone;
    emailController.text = AuthCubit.get(context).userModel!.email;
    super.initState();
  }
  TimeRange ? _timeRange;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: (state is GetUserDataLoadingState)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 100.r,
                            backgroundImage: NetworkImage((AuthCubit.get(
                                            context)
                                        .userModel!
                                        .photo ==
                                    '')
                                ? 'https://firebasestorage.googleapis.com/v0/b/pharmacy-f7702.appspot.com/o/images.jpg?alt=media&token=0aa2b534-e0cf-4ccc-814f-28c57a12d383'
                                : AuthCubit.get(context).userModel!.photo),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              (state is UploadImageStateLoading)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      disable: true,
                                      size: Size(150.w, 40.h),
                                      widget: const Text("Select from gallery"),
                                      function: () {
                                        AuthCubit.get(context)
                                            .pickImageGallary(context);
                                      },
                                    ),
                              (state is UploadImageStateLoading)
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      size: Size(150.w, 40.h),
                                      disable: true,
                                      widget: const Text("Select from camera"),
                                      function: () {
                                        AuthCubit.get(context)
                                            .pickImageCamera(context);
                                      },
                                    ),
                            ],
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  controller: emailController,
                                  fieldValidator: emailValidator,
                                  hint: 'email',
                                  iconData: Icons.email,
                                  enable: false,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  height: 20.h,
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
                                  enable: enable,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomTextField(
                                  textInputType: TextInputType.phone,
                                  controller: phoneController,
                                  fieldValidator: phoneValidator,
                                  hint: 'phone',
                                  iconData: Icons.phone,
                                  enable: enable,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                BlocConsumer<LayoutCinemaOwnerCubit,
                                    LayoutCinemaOwnerState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {

                                    return (state is LayoutCinemaChangLoading)?
                                    const Center(child: CircularProgressIndicator(),):
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
                                              if (kDebugMode) {
                                                print(value);
                                              }
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
                                          ? Text("From : $from To $to")
                                          : const Text('Select time'),
                                      disable: true,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    (state is RegisterLoadingState)
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : CustomButton(
                                            function: () {
                                              setState(() {
                                                enable = !enable;
                                              });
                                            },
                                            widget: const Text("Start Edit"),
                                            size: Size(150.w, 40.h),
                                            radius: 20.r,
                                            disable: !enable,
                                          ),
                                    (state is UpdateDataLoadingState)
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : CustomButton(
                                            function: () async
                                              {
                                                LayoutCinemaOwnerCubit.get(context).
                                                editCinemaInfo(open:
                                                _timeRange!.startTime.hour.toString(),
                                                    close: _timeRange!.endTime.hour.toString());
                                              if (formKey.currentState!
                                                  .validate()) {
                                                AuthCubit.get(context)
                                                    .update(
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        age: ageController.text,
                                                        name:
                                                            nameController.text)
                                                    .then((value) {})
                                                    .then((value) {
                                                  enable = false;
                                                });
                                              }
                                            },
                                            widget:
                                                const Text("confirm Update"),
                                            size: Size(150.w, 40.h),
                                            radius: 20.r,
                                            disable: enable,
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomButton(
                                  function: () async {

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
                                      AuthCubit.get(context).userModel = null;
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                          (route) => false);
                                    });
                                  },
                                  widget: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.logout),
                                      const Text("Logout")
                                    ],
                                  ),
                                  size: Size(150.w, 40.h),
                                  radius: 20.r,
                                  disable: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
