import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/components/buttons/custom_button.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/header.dart';
import 'package:movie_flutterr/view/components/login%20&%20signup/login_signup_switch.dart';
import 'package:movie_flutterr/view/pages/auth/signup_page.dart';
import 'package:movie_flutterr/view_model/cubit/login/login_cubit.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';

import '../../../constants/validator.dart';
import '../admin/layout_admin.dart';
import '../cinema_owner/CinemaOwnerLayout.dart';
import '../cinema_owner/add_cinema.dart';
import '../main_page.dart';
import '../main_page/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

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
          controller: emailController,
          fieldValidator: emailValidator,
          hint: 'email',
          iconData: Icons.email,
        ),
        SizedBox(
          height: 20.h,
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
      ],
    );
  }

  //contains forget password and login button and signup text
  Widget loginAndSignup(LoginCubit myCubit, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45.h,
        ),
        Center(
            child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is UserLoginSuccess) {


              if (state.role == "3") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(

                            )),
                    (route) => false);
              } else if (state.role=="2"){
                if(state.cinemaID =='')
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:  (context)=>const CreateCinema()), (route) => false);
                }else{
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CinemaOwnerLayout(),), (route) => false);

                }
              }else {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LayOutScreenAdmin()),
                    (route) => false);
              }
            }
          },
          builder: (context, state) {
            return (state is UserLoginLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomButtonOne(
                    buttonTitle: "Login",
                    onClick: () {
                      if (emailController.text.trim().isEmpty ||
                          passwordController.text.trim().isEmpty) {
                        return;
                      }

                      myCubit.login(
                          email: emailController.text.trim(),
                          password: passwordController.text);
                    });
          },
        )),
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
