import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/MoviesScreen.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/add%20MainShops.dart';

import '../../../view_model/cubit/auth/auth_cubit.dart';
import '../../components/custom_button.dart';
import 'mini_shop_screen_details.dart';

class MainShopsScreen extends StatefulWidget {
  const MainShopsScreen({Key? key}) : super(key: key);

  @override
  State<MainShopsScreen> createState() => _MainShopsScreenState();
}

class _MainShopsScreenState extends State<MainShopsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context)
        .getMiniShops(cinemaID: AuthCubit.get(context).userModel!.cinemaID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Shops'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            AuthCubit.get(context)
                .getMiniShops(cinemaID: AuthCubit.get(context).userModel!.cinemaID);
          },
          child: (state is GetMiniShopesLoading)? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  widget: const Text("Create Main Shops"),
                  function: () {
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                    return const AddMainShops();
                    },
                    ));
                  },
                  disable: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomCardMovie(image: AuthCubit.get(context).miniShops[index].photo,
                          title: AuthCubit.get(context).miniShops[index].name, function: ()
                          {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return  MiniShopDetalils(miniShopsModel: AuthCubit.get(context).miniShops[index] ,);
                              },
                            ));
                          });
                    },
                    itemCount: AuthCubit.get(context).miniShops.length,
                    shrinkWrap: true,
                  ),
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
