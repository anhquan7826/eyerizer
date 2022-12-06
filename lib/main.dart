import 'package:eyerizer/services/shared_preferences.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:eyerizer/view/cam_color_picker/cam_color_picker.splash.dart';
import 'package:eyerizer/view/color_picker/color_picker.splash.dart';
import 'package:eyerizer/view/colorblind_simulator/colorblind_simulator.splash.dart';
import 'package:eyerizer/view/colorblind_test/colorblind_test.splash.dart';
import 'package:eyerizer/view/greeting_screen/greeting_screen.view.dart';
import 'package:eyerizer/view/home/home.view.dart';
import 'package:eyerizer/view/splash_screen/splash_screen.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.mainBackground,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.mainBackground,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  Application();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(),
          ),
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/greeting': (context) => const GreetingScreen(),
          '/home': (context) => const HomeScreen(),
          '/cam_color_picker': (context) => const CameraColorPickerSplash(),
          '/color_blind_test': (context) => const ColorblindTestSplash(),
          '/colorblind_simulator': (context) => const ColorblindSimulatorSplash(),
          '/color_picker': (context) => const ColorPickerSplash(),
        },
      ),
    );
  }
}
