import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/view/components/custom_button.dart';
import 'package:movie_flutterr/view_model/cubit/Get_halls/get_halls_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';

import 'create_halls.dart';
import 'edit_halls.dart';
import 'get_hall_info.dart';

class HallsScreen extends StatefulWidget {
  const HallsScreen({Key? key}) : super(key: key);

  @override
  State<HallsScreen> createState() => _HallsScreenState();
}

class _HallsScreenState extends State<HallsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AuthCubit.get(context).getHalls(cinemaID: AuthCubit.get(context).userModel!.cinemaID);
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
            title: const Text("Halls Screen"),
          ),
          body: SizedBox(
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                AuthCubit.get(context).getHalls(
                    cinemaID: AuthCubit.get(context).userModel!.cinemaID);
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      widget: const Text("Create Halls"),
                      function: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CreateHalles();
                          },
                        ));
                      },
                      disable: true,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                               'Name : ${AuthCubit.get(context).halls[index].name}' ,style: const TextStyle(fontSize: 14 , color: Colors.white),),
                            subtitle: Text(
                              'Number of Seats : ${AuthCubit.get(context).halls[index].seats}' ,style: const TextStyle(fontSize: 14 , color: Colors.white),),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: ()
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)
                                    {
                                      return EditHalls(hallsModel: AuthCubit.get(context).halls[index],);
                                    }));
                                  },
                                  icon: const Icon(Icons.edit ,color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: ()
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return GetHallInfo(hallName:  AuthCubit.get(context).halls[index].name,cinemaID: AuthCubit.get(context).halls[index].cinemaID,);
                                    },));
                                  },
                                  icon: const Icon(Icons.info ,color: Colors.white),
                                ),
                              ],
                            )
                          ),
                        );
                      },
                      itemCount: AuthCubit.get(context).halls.length,
                      shrinkWrap: true,
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
