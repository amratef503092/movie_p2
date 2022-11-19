import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_flutterr/view/pages/auth/login_page.dart';
import 'package:movie_flutterr/view/pages/main_page.dart';
import 'package:movie_flutterr/view_model/database/local/cache_helper.dart';
import 'package:movie_flutterr/view_model/database/network/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  await CacheHelper.init();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(CacheHelper.get(key: LOGIN_CHECK_KEY) == null){
      CacheHelper.put(value: false,key: LOGIN_CHECK_KEY);
    }


    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: /*CacheHelper.get(key: LOGIN_CHECK_KEY)? HomePage() :*/ LoginPage(),
        );
      },
      designSize: const Size(360, 800),
    );
  }
}
