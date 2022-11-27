import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' as io;
import 'package:movie_flutterr/model/cinema_owner_model/snacks.dart';
import 'package:movie_flutterr/view/components/custom_textfield.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../components/custom_button.dart';
class EditSnacks extends StatefulWidget {
   EditSnacks({Key? key , required this.snacksModel}) : super(key: key);
  SnacksModel? snacksModel;

  @override
  State<EditSnacks> createState() => _EditSnacksState();
}

class _EditSnacksState extends State<EditSnacks> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController price = TextEditingController();


  RegExp regExp = RegExp(r"^[0-9][3]$", caseSensitive: false);
  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.snacksModel!.name;
    price.text = widget.snacksModel!.price.toString();
    super.initState();
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AuthCubit
            .get(context)
            .imageSnack = null;
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add  Main Shops'),
        ),
        body: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Form(
            key: formKey,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Add Main Shops",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),

                        AuthCubit
                            .get(context)
                            .imageSnack == null
                            ?  Image.network(widget.snacksModel!.photo,)
                            : Image(
                          image: FileImage(
                            io.File(AuthCubit
                                .get(context)
                                .imageSnack!
                                .path),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButton(
                            widget: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.camera_alt),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Choose snacks image'),
                              ],
                            ),
                            function: () {
                              AuthCubit.get(context).pickImageGallarySnack(
                                  context);
                            },
                            disable: true),
                        SizedBox(
                          height: 50.h,
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        CustomTextField(
                          controller: nameController,
                          fieldValidator: (String value) {
                            if (value
                                .trim()
                                .isEmpty || value == ' ') {
                              return 'This field is required';
                            }
                          },
                          hint: 'Name Shops',
                          iconData: Icons.perm_identity,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: price,
                          fieldValidator: (String value) {
                            if (value
                                .trim()
                                .isEmpty || value == ' ') {
                              return 'This field is required';
                            }
                          },
                          hint: 'price',
                          iconData: Icons.price_change,
                        ),

                        SizedBox(
                          height: 50.h,
                        ),

                        SizedBox(
                          height: 50.h,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Text("Out of stock" , style: TextStyle(color: Colors.white,fontSize: 30),),
                          Switch(
                            value: widget.snacksModel!.outOfStock,
                            onChanged: (value) {
                              setState(() {
                                widget.snacksModel!.outOfStock = value;
                                print(widget.snacksModel!.outOfStock);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                        ],),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            // TODO: implement listener
                            if(state is EditSnacksSuccessful){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Add Mini Shops Successful')));
                              // here get minin shops D:
                              AuthCubit.get(context).getSnacks(
                                  miniShopId:widget.snacksModel!.miniShopId);
                              nameController.clear();
                              AuthCubit
                                  .get(context)
                                  .imageSnack = null;
                              Navigator.maybePop(context);
                            }
                          },
                          builder: (context, state) {
                            return (state is EditSnacksLoading)? Center(child: CircularProgressIndicator(),)
                                :CustomButton(
                                widget: const Text(
                                  'Add Main Shops',
                                  style: TextStyle(color: Colors.white),
                                ),
                                function: () {
                                  if (formKey.currentState!.validate() ) {
                                    AuthCubit.get(context).editSnacks(
                                      outOfStock: widget.snacksModel!.outOfStock,
                                        snackID: widget.snacksModel!.id,
                                        photo: (AuthCubit
                                            .get(context)
                                            .snckImageUrl == null)
                                            ? widget.snacksModel!.photo
                                            : AuthCubit
                                            .get(context)
                                            .snckImageUrl!,
                                        name: nameController.text,

                                    price:int.parse( price.text));
                                  }
                                },
                                disable: true);
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
