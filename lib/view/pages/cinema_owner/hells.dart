import 'package:flutter/material.dart';
import 'package:movie_flutterr/view/components/custom_button.dart';
import 'package:movie_flutterr/view_model/cubit/layout_cinema_owner_cubit/layout_cinema_owner_cubit.dart';

import 'create_halls.dart';
class HallsScreen extends StatefulWidget {
  const HallsScreen({Key? key}) : super(key: key);

  @override
  State<HallsScreen> createState() => _HallsScreenState();
}

class _HallsScreenState extends State<HallsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    LayoutCinemaOwnerCubit.get(context).getHalls();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halls Screen"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: () async {
            LayoutCinemaOwnerCubit.get(context).getHalls();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
               CustomButton(widget: const Text("Create Halls"),
                   function: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CreateHalles();
                  },));
                   },disable: true,),
                ListView.builder(physics: NeverScrollableScrollPhysics(),itemBuilder:
                    (context,index){
                  return Card(
                    child: ListTile(
                      title: Text("Halls $index"),
                    ),
                  );
                },itemCount: 10,shrinkWrap: true,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
