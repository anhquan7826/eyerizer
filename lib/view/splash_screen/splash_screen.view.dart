import 'package:eyerizer/services/shared_preferences.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (Application().sharedPreferences.getBool('haveLaunchedBefore') != true) {
        Navigator.pushReplacementNamed(context, '/greeting');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: SvgPicture.asset(
                'assets/logo.svg',
                color: AppColors.mainText,
                width: 40.w,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Text(
              'EYERIZER',
              style: TextStyle(
                color: AppColors.mainText,
                fontWeight: FontWeight.w600,
                fontSize: 42,
                letterSpacing: 5,
              ),
            ),
            const Text(
              'Color blind see',
              style: TextStyle(
                color: AppColors.mainText,
                fontSize: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
