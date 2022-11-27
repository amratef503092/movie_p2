import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/model/cinema_owner_model/MiniShops_model.dart';
import 'package:movie_flutterr/view/components/custom_button.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';

class AddSnacks extends StatefulWidget {
  AddSnacks({Key? key, required this.miniShopsModel}) : super(key: key);
  MiniShopsModel miniShopsModel;

  @override
  State<AddSnacks> createState() => _AddSnacksState();
}

class _AddSnacksState extends State<AddSnacks> {
  @override
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController price = TextEditingController();

  bool showPassword = false;
  List<String> gender = ['Male', 'Female'];
  RegExp regExp = RegExp(r"^[0-9]{2}$", caseSensitive: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                      SizedBox(
                        height: 50.h,
                      ),
                      const Text(
                        "Add Snacks",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthCubit.get(context).imageSnack == null
                          ? const Text(
                              "Select Image Please",
                              style: TextStyle(color: Colors.white),
                            )
                          : Image(
                              image: FileImage(
                                io.File(
                                    AuthCubit.get(context).imageSnack!.path),
                              ),
                            ),
                      CustomButton(
                          disable: true,
                          widget: Text("Add Image"),
                          function: () {
                            AuthCubit.get(context)
                                .pickImageGallarySnack(context);
                          }),
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
                        controller: price,
                        textInputType: TextInputType.number,
                        fieldValidator: (String value) {
                          if (value.trim().isEmpty || value == ' ') {
                            return 'This field is required';
                          }
                        },
                        hint: 'price',
                        iconData: Icons.price_change,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if(state is AddSnacksSuccessful){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Add Snack Successful '),
                                backgroundColor: Colors.green,
                              ),
                            );
                            price.clear();
                            nameController.clear();
                            AuthCubit.get(context).imageSnack = null;
                            Navigator.pop(context);
                          }
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return (state is AddSnacksLoading)? Center(child: CircularProgressIndicator(),):CustomButton(
                              disable: true,
                              widget: Text("Add Snacks"),
                              function: () {
                                AuthCubit.get(context).addSnacks(
                                    name: nameController.text,
                                    price: int.parse(price.text),
                                    miniShopId: widget.miniShopsModel.id);
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
