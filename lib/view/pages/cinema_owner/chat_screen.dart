import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/view/chat_screen.dart';
import 'package:movie_flutterr/view/components/custom_data_empty.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/main%20page/main_page_cubit.dart';

class ChatScreenCinema extends StatefulWidget {
  const ChatScreenCinema({Key? key}) : super(key: key);

  @override
  State<ChatScreenCinema> createState() => _ChatScreenCinemaState();
}

class _ChatScreenCinemaState extends State<ChatScreenCinema> {
  @override
  void initState() {
    // TODO: implement initState
    MainPageCubit.get(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: BlocConsumer<MainPageCubit, MainPageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MainPageCubit.get(context);
          return (state is GetUsersLoading)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (cubit.users.isEmpty)?DataEmptyWidget():ListView.builder(
                  itemCount: cubit.users.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  cinemaID: AuthCubit.get(context).userModel!.cinemaID,
                                      userID: cubit.users[index].id,
                                      receiverName: cubit.users[index].name,
                                      receiverId: cubit.users[index].id,
                                      cinema: true,
                                    )));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(cubit.users[index].photo),
                        ),
                        title: Text(
                          cubit.users[index].name,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        subtitle: Text(cubit.users[index].email,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
