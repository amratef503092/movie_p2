import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/buttons/custom_button.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/header.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/login_signup_switch.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/social_login.dart';
import 'package:movie_flutterr/view/pages/auth/login_page.dart';
import 'package:movie_flutterr/view_model/cubit/signup/signup_cubit.dart';
import 'package:movie_flutterr/view_model/database/network/end_points.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          SignupCubit myCubit = SignupCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: BACKGROUND_COLOR,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(pageName: "Sign up"),
                      SizedBox(
                        height: 46.h,
                      ),
                      textFields(),
                      SizedBox(
                        height: 6.h,
                      ),
                      loginAndSignup(myCubit, context),
                      SizedBox(
                        height: 50.h,
                      ),
                      SocialLogin()
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  //contains userName , email , password and password confirmation textfields
  Widget textFields() {
    return Column(
      children: [
        CustomTextField(
          borderRadius: 10,
            isPassword: false,
            controller: userNameController,
            hintText: "User Name"),
        SizedBox(
          height: 50.h,
        ),
        CustomTextField(
          borderRadius: 10,
            isPassword: false,
            controller: emailController,
            hintText: "E-Mail"),
        SizedBox(
          height: 50.h,
        ),
        CustomTextField(
          borderRadius: 10,
            isPassword: true,
            controller: passwordController,
            hintText: "Password"),
        SizedBox(
          height: 50.h,
        ),
        CustomTextField(
          borderRadius: 10,
            isPassword: true,
            controller: passwordConfirmationController,
            hintText: "Confirm Password"),
      ],
    );
  }

  //contains signup button and login text
  Widget loginAndSignup(SignupCubit myCubit, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45.h,
        ),
        Center(
            child: CustomButton(
                buttonTitle: "Sign up",
                onClick: () {
                  if (emailController.text.trim().isEmpty ||
                      userNameController.text.trim().isEmpty ||
                      passwordConfirmationController.text.trim().isEmpty ||
                      passwordController.text.trim().isEmpty ||
                      passwordController.text.trim() !=
                          passwordConfirmationController.text.trim()) {
                    print("NO");
                    return;
                  }
                  var json = {
                    'email': emailController.text.trim(),
                    'password': passwordController.text.trim(),
                    'name': userNameController.text.trim()
                  };
                  myCubit.registerUser(json, SIGNUP_ENDPOINT, context);
                })),
        SizedBox(
          height: 35.h,
        ),
        LoginSignUpSwitcher(
          clickableTitle: "Login",
          title: "Already have an account? ",
          navigatorFunction: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        )
      ],
    );
  }
}
