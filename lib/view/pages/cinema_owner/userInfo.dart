import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

import '../../../constants/validator.dart';
import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../components/custom_textfield.dart';
class UserInfoScreen extends StatefulWidget {
   UserInfoScreen({Key? key ,
    required this.cinemaID ,
     required  this.orderStatus ,
     required this.ticketID ,
   required this.userID
   }) :
         super(key: key);
  String cinemaID ;
  String orderStatus;
  String userID;
  String ticketID;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getUserInfoData(userID: widget.userID);




    super.initState();
  }
  TextEditingController emailController = TextEditingController();


  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool showPassword = false;
  bool enable = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        if(state is GetUserInfoSuccess){
          emailController.text = MainPageCubit.get(context).user!.email;
          nameController.text = MainPageCubit.get(context).user!.name;
          ageController.text = MainPageCubit.get(context).user!.age;
          genderController.text = MainPageCubit.get(context).user!.gender;
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        var authCubit = MainPageCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('User Info'),
          ),
          body: (state is GetUserInfoLoading)? Center(child: CircularProgressIndicator(),): SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: (state is GetUserDataLoadingState)
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100.r,
                      backgroundImage: NetworkImage((authCubit
                          .user!.photo ==
                          '')
                          ? 'https://firebasestorage.googleapis.com/v0/b/pharmacy-f7702.appspot.com/o/images.jpg?alt=media&token=0aa2b534-e0cf-4ccc-814f-28c57a12d383'
                          : authCubit.user!.photo),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
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
                          CustomTextField(
                            textInputType: TextInputType.phone,
                            controller: genderController,
                            fieldValidator: (String? value) {
                              if (value!.isEmpty) {
                                return "this Field is requried";
                              }
                            },
                            hint: 'gender',
                            iconData: FontAwesomeIcons.venusMars,
                            enable: false,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomTextField(
                            textInputType: TextInputType.number,
                            controller: ageController,
                            fieldValidator: (String? value) {
                              if (value!.isEmpty) {
                                return "this Field is requried";
                              }
                            },
                            hint: 'age',
                            iconData: FontAwesomeIcons.birthdayCake,
                            enable: enable,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                        ],
                      ),

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
