import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spin_360/play_list.dart';
import 'package:spin_360/recording_screen.dart';
import 'package:spin_360/searching_devices.dart';
import 'package:spin_360/video_saving.dart';
import 'camera_screen.dart';
import 'checking.dart';
import 'login_screen.dart';
import 'mainscreen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 800),
        builder: (context,_){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Spark',
            theme: ThemeData(
              //primarySwatch: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: LoginScreen(),
          );
        },
    );
  }
}
