import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/view/pages/auth/login_page.dart';
import 'package:movie_flutterr/view_model/cubit/auth/auth_cubit.dart';
import 'package:movie_flutterr/view_model/cubit/layout_cinema_owner_cubit/layout_cinema_owner_cubit.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';
import 'package:movie_flutterr/view_model/database/network/dio_helper.dart';

import 'constants/blocObserver.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (CacheHelper.get(key: LOGIN_CHECK_KEY) == null) {
      CacheHelper.put(value: false, key: LOGIN_CHECK_KEY);
    }

    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit()..getUserData(),
            ),
            BlocProvider(
                create: (context) => LayoutCinemaOwnerCubit()
                  ..getCinemaInfo()
                  ..getCinemaInfo()),
          ],
          child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: BACKGROUND_COLOR,
              buttonColor: RED_COLOR,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(RED_COLOR),
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: RED_COLOR,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: BACKGROUND_COLOR,
                type: BottomNavigationBarType.fixed,
              ),
              cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xff171717),
                elevation: 5,
                shadowColor: Colors.white,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: /*CacheHelper.get(key: LOGIN_CHECK_KEY)? HomePage() :*/ LoginPage(),
          ),
        );
      },
      designSize: const Size(360, 800),
    );
  }
}
