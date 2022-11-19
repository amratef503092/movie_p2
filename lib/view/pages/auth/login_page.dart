import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/buttons/custom_button.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/header.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/login_signup_switch.dart';
import 'package:movie_flutterr/view/pages/auth/signup_page.dart';
import 'package:movie_flutterr/view_model/cubit/login/login_cubit.dart';
import 'package:movie_flutterr/view_model/database/network/end_points.dart';

import '../../components/login & signup/social_login.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          LoginCubit myCubit = LoginCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: BACKGROUND_COLOR,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(pageName: "Login"),
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

  //contains email and password textfields
  Widget textFields() {
    return Column(
      children: [
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
      ],
    );
  }

  //contains forget password and login button and signup text
  Widget loginAndSignup(LoginCubit myCubit, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            "Forget Password?",
            style: GoogleFonts.roboto(
                color: RED_COLOR,
                decoration: TextDecoration.underline,
                fontSize: 9.sp),
          ),
        ),
        SizedBox(
          height: 45.h,
        ),
        Center(
            child: CustomButton(
                buttonTitle: "Login",
                onClick: () {
                  if (emailController.text.trim().isEmpty ||
                      passwordController.text.trim().isEmpty) {
                    return;
                  }
                  var json = {
                    'email': emailController.text.trim(),
                    'password': passwordController.text.trim()
                  };
                  myCubit.loginUser(json, LOGIN_ENDPOINT, context);
                })),
        SizedBox(
          height: 35.h,
        ),
        LoginSignUpSwitcher(
          clickableTitle: "Sign up",
          title: "Don't have an account? ",
          navigatorFunction: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
        )
      ],
    );
  }
}
