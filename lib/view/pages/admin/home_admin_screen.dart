import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).getAdmin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var authCubit = AuthCubit.get(context);

          return (state is GetUserDataLoadingState)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              authCubit.getAdmin();
                            },
                            icon: const Icon(Icons.refresh , color: Colors.white,),
                          )),
                      Expanded(
                        child: ListView.builder(
                            itemCount: authCubit.adminData.length,
                            itemBuilder: (context, index) {
                              if (!authCubit.adminData[index].ban) {
                                return Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(authCubit
                                            .adminData[index].photo
                                            .toString()),
                                        radius: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name : ${authCubit.adminData[index].name}",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                "Phone : ${authCubit.adminData[index].phone}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                            authCubit.adminData[index].online
                                                ? Row(
                                                    children: [
                                                      Text("Status : ",
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                      const Text(
                                                        "online",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Text("Status : ",
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .white)),
                                                      const Text(
                                                        "offline",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    "You want Delete Account ?"),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    Text(
                                                        "If You click ok you will Ban this Account")
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      child:
                                                          const Text("Cancel"),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(AuthCubit.get(
                                                                  context)
                                                              .adminData[index]
                                                              .id)
                                                          .update({
                                                        'ban': true
                                                      }).then((value) {
                                                        Navigator.of(ctx).pop();
                                                        AuthCubit.get(context)
                                                            .getAdmin();
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      child: const Text("Ok"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.ban,
                                            color: Colors.red,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            _launchInBrowser(Uri(
                                                scheme: 'https',
                                                host: 'wa.me',
                                                path:
                                                    "+${authCubit.adminData[index].phone}"));
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.phone,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                );
                              } else {
                                return Card(
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                authCubit.adminData[index].photo
                                                    .toString()),
                                            radius: 40,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Name : ${authCubit.adminData[index].name}",
                                                style: TextStyle(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                  "Phone : ${authCubit.adminData[index].phone}",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              authCubit.adminData[index].online
                                                  ? Row(
                                                      children: [
                                                        Text("Status : ",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                        Text(
                                                          "online",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        )
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Text("Status : ",
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white)),
                                                        Text(
                                                          "offline",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          ),
                                          // TextButton(
                                          //   onPressed: () {
                                          //     FirebaseFirestore.instance
                                          //         .collection('users')
                                          //         .doc(AuthCubit.get(
                                          //         context)
                                          //         .adminData[index]
                                          //         .id)
                                          //         .update({
                                          //       'ban': true
                                          //     }).then((value) {
                                          //
                                          //       Navigator.of(context).pop();
                                          //       AuthCubit.get(context).getAdmin();
                                          //       setState(() {});
                                          //     });
                                          //   },
                                          //   child: Container(
                                          //     padding:
                                          //     const EdgeInsets.all(
                                          //         14),
                                          //     child: const Text("Ok"),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text(
                                                  "You want Remove Ban Account ?"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Text(
                                                      "If You click ok you will Remove Ban From this Account ? ")
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: const Text("Cancel"),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(AuthCubit.get(
                                                                context)
                                                            .adminData[index]
                                                            .id)
                                                        .update({
                                                      'ban': false
                                                    }).then((value) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      AuthCubit.get(context)
                                                          .getAdmin();
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: const Text("Ok"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100.h,
                                          color: Colors.black.withOpacity(0.5),
                                          child: Center(
                                            child: Text(
                                              "Banned",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}
