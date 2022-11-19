import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_flutterr/view_model/cubit/login/login_cubit.dart';

import '../../../view_model/cubit/social_buttons/social_buttons_cubit.dart';

class HoverIcon extends StatelessWidget {
  HoverIcon({
    Key? key,
    required this.btnIndex,
    required this.imageName,
  }) : super(key: key);

  int btnIndex;
  String imageName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialButtonsCubit(),
      child: BlocBuilder<SocialButtonsCubit, SocialButtonsState>(
        builder: (context, state) {
          SocialButtonsCubit myCubit = SocialButtonsCubit.get(context);
          return GestureDetector(
            onTap: () {
              myCubit.showHover(btnIndex, true);
            },
            child: Stack(
              children: [
                myCubit.isButtonHover(btnIndex)
                    ? Image.asset(
                        imageName,
                        width: 26,
                        color: Colors.blue,
                      )
                    : SizedBox(),
                Image.asset(
                  imageName,
                  width: 25,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
