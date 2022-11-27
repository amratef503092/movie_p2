import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/constants/constants.dart';
import 'package:movie_flutterr/model/cinema_owner_model/snacks.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

class BuySnacks extends StatefulWidget {
  BuySnacks({Key? key, required this.ticketId, required this.cinemaID})
      : super(key: key);
  String ticketId;
  String cinemaID;

  @override
  State<BuySnacks> createState() => _BuySnacksState();
}

class _BuySnacksState extends State<BuySnacks> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getSnacks(cinemaID: widget.cinemaID);
    super.initState();
  }

  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is BuySnacksSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Snacks Bought Successfully'),
          ));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainPage();
              },
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Buy Snacks'),
          ),
          body: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: MainPageCubit.get(context).snacksModel.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 0.4.sw,
                  height: 0.1.sh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          MainPageCubit.get(context).snacksModel[index].photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        MainPageCubit.get(context).snacksModel[index].name,
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
                                .snacksModel[index]
                                .price
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
                      Container(
                        width: 0.5.sw,
                        height: 0.05.sh,
                        decoration: BoxDecoration(
                          color: RED_COLOR,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    // 1
                                    // 2

                                    MainPageCubit.get(context)
                                            .snacksModel[index]
                                            .price *
                                        MainPageCubit.get(context)
                                            .snacksModel[index]
                                            .quantity++;
                                    MainPageCubit.get(context)
                                        .snacksModel[index]
                                        .totalPrice = MainPageCubit.get(context)
                                            .snacksModel[index]
                                            .price *
                                        MainPageCubit.get(context)
                                            .snacksModel[index]
                                            .quantity;
                                  });
                                  print(MainPageCubit.get(context)
                                      .snacksModel[index]
                                      .totalPrice
                                      .toString());
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            Text(
                              MainPageCubit.get(context)
                                  .snacksModel[index]
                                  .quantity
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (MainPageCubit.get(context)
                                            .snacksModel[index]
                                            .quantity >
                                        0) {
                                      print(totalPrice);
                                      MainPageCubit.get(context)
                                          .snacksModel[index]
                                          .quantity--;
                                      MainPageCubit.get(context)
                                              .snacksModel[index]
                                              .totalPrice =
                                          (MainPageCubit.get(context)
                                                  .snacksModel[index]
                                                  .price *
                                              MainPageCubit.get(context)
                                                  .snacksModel[index]
                                                  .quantity);
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          bottomSheet: SizedBox(
            width: 1.sw,
            height: 0.1.sh,
            child: ElevatedButton(
              onPressed: () {
                int total = 0;
                List<SnacksModel> snacksBuy = [];
                MainPageCubit.get(context).snacksModel.forEach((element) {
                  if (element.quantity > 0) {
                    total += element.totalPrice;
                    print(element.quantity);
                    print(element.name);

                    snacksBuy.add(element);
                  }
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Total Price'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Total Price of Snacks $total SAR'),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              MainPageCubit.get(context).buySnacks(
                                 totalPrice: total,
                                  ticketID: widget.ticketId,
                                  snacksModel: snacksBuy);
                              Navigator.pop(context);
                            },
                            child: Text('Confirm')),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Confirm',
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
