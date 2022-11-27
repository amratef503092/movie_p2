import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';
import '../../../model/cinema_owner_model/snacks.dart';
import '../../../view_model/cubit/main page/main_page_cubit.dart';
class ShowSnack extends StatefulWidget {
   ShowSnack({Key? key ,required this.cinemaId}) : super(key: key);
  String cinemaId;

  @override
  State<ShowSnack> createState() => _ShowSnackState();
}

class _ShowSnackState extends State<ShowSnack> {
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getSnacks(cinemaID: widget.cinemaId);
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
                      
                    ],
                  ),
                );
              },
            ),
          ),

        );
      },
    );
  }
}
