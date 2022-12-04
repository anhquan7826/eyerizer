import 'package:eyerizer/view/cam_color_picker/cam_color_picker.view.dart';
import 'package:eyerizer/view/color_picker/color_picker.view.dart';
import 'package:eyerizer/view/colorblind_simulator/colorblind_simulator.view.dart';
import 'package:eyerizer/view/colorblind_test/colorblind_test.view.dart';
import 'package:eyerizer/view/home/home.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const HomeScreen(),
          '/cam_color_picker': (context) => const CameraColorPickerScreen(),
          '/color_blind_test': (context) => const ColorblindTestScreen(),
          '/colorblind_simulator': (context) => const ColorblindSimulator(),
          '/color_picker': (context) => const ColorPicker(),
        },
      ),
    );
  }
}