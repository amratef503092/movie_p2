import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/view/pages/user/buy_snacks.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

class ShowSnaks extends StatefulWidget {
  ShowSnaks(
      {Key? key,
      required this.orderStasus,
      required this.ticketID,
      required this.cinemaID})
      : super(key: key);
  String orderStasus;
  String ticketID;
  String cinemaID;

  @override
  State<ShowSnaks> createState() => _ShowSnaksState();
}

class _ShowSnaksState extends State<ShowSnaks> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getMySnacks(ticketId: widget.ticketID);
    super.initState();
  }

  int totalPrice = 0;

  String totalPriceC() {
    totalPrice = 0;
    MainPageCubit.get(context).getMySnacksList.forEach((element) {
      totalPrice = totalPrice + (element.price * element.quantity);
    });
    return totalPrice.toString();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Show Snaks"),
            actions: [
              (AuthCubit.get(context).userModel!.cinemaID != '')
                  ? SizedBox()
                  : (widget.orderStasus == 'Pending')
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuySnacks(
                                          ticketId: widget.ticketID,
                                          cinemaID: widget.cinemaID,
                                        )));
                          },
                          icon: const Icon(Icons.add))
                      : const SizedBox()
            ],
          ),
          body: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: MainPageCubit.get(context).getMySnacksList.length,
              itemBuilder: (context, index2) {
                return InkWell(
                  onTap: () {
                    if(AuthCubit.get(context).userModel!.cinemaID != ''){

                    }else{
                      if (widget.orderStasus == "Pending") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(MainPageCubit.get(context)
                                      .getMySnacksList[index2]
                                      .name),
                                  content: SizedBox(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (MainPageCubit.get(context)
                                                        .getMySnacksList[
                                                    index2]
                                                        .quantity >
                                                        1) {
                                                      MainPageCubit.get(context)
                                                          .getMySnacksList[index2]
                                                          .quantity--;
                                                    }
                                                  });
                                                },
                                                icon: const Icon(Icons.remove)),
                                            Text(
                                                "Quantity: ${MainPageCubit.get(context).getMySnacksList[index2].quantity}"),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    MainPageCubit.get(context)
                                                        .getMySnacksList[index2]
                                                        .quantity++;
                                                  });
                                                },
                                                icon: const Icon(Icons.add)),
                                          ],
                                        ),
                                        Text(
                                            "Price : ${MainPageCubit.get(context).getMySnacksList[index2].quantity * MainPageCubit.get(context).getMySnacksList[index2].price}"),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  MainPageCubit.get(context)
                                                      .editSnacks(
                                                      snackID: MainPageCubit
                                                          .get(context)
                                                          .getMySnacksList[
                                                      index2]
                                                          .id,
                                                      tiketID:
                                                      widget.ticketID,
                                                      index2: index2);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Save")),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  MainPageCubit.get(context)
                                                      .deleteSnack(
                                                      snackID: MainPageCubit
                                                          .get(context)
                                                          .getMySnacksList[
                                                      index2]
                                                          .id,
                                                      tiketID:
                                                      widget.ticketID,
                                                      index2: index2);
                                                },
                                                child: const Text("Delete"))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content:
                            Text("You can't add snacks to Modify order")));
                      }
                    }

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesScreen()));
                  },
                  child: Container(
                    width: 0.4.sw,
                    height: 0.1.sh,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(MainPageCubit.get(context)
                            .getMySnacksList[index2]
                            .photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 0.05.sh,
                        ),
                        Text(
                          MainPageCubit.get(context)
                              .getMySnacksList[index2]
                              .name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Quantity: ${MainPageCubit.get(context).getMySnacksList[index2].quantity}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              MainPageCubit.get(context)
                                  .getMySnacksList[index2]
                                  .totalPrice
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'SAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomSheet: Container(
            width: double.infinity,
            height: 0.1.sh,
            color: RED_COLOR,
            child: Center(
              child: Text(
                'Total Price: ${totalPriceC()} SAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
