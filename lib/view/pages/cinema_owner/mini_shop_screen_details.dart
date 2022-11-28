import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/model/cinema_owner_model/MiniShops_model.dart';
import 'package:movie_flutterr/view/components/custom_data_empty.dart';
import 'package:movie_flutterr/view/pages/cinema_owner/MoviesScreen.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import 'Add_snacks.dart';
import 'EditMiniShop.dart';
import 'edit_snacks.dart';
class MiniShopDetalils extends StatefulWidget {
   MiniShopDetalils({Key? key, required this.miniShopsModel}) : super(key: key);
  MiniShopsModel? miniShopsModel;
  @override
  State<MiniShopDetalils> createState() => _MiniShopDetalilsState();
}

class _MiniShopDetalilsState extends State<MiniShopDetalils> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).getSnacks(miniShopId: widget.miniShopsModel!.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Shop Details'),
        actions: [
          IconButton(
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return  EditMiniShop(miniShopsModel: widget.miniShopsModel,);
              }));
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return AddSnacks(miniShopsModel: widget.miniShopsModel!,);
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {

    },
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: (AuthCubit.get(context).snacks.isEmpty)?DataEmptyWidget():GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
            itemBuilder: (context, index) {
              return CustomCardMovie(
                image: AuthCubit.get(context).snacks[index].photo,
                function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  {
                    return EditSnacks(snacksModel: AuthCubit.get(context).snacks[index],);
                  }));

                },

                title: AuthCubit.get(context).snacks[index].name,
              );
            },

            itemCount: AuthCubit.get(context).snacks.length),
      );
    },
      ),

    );
  }
}
