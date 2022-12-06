import 'package:eyerizer/services/shared_preferences.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        child: Center(
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
                height: 10.h,
              ),
              const Text(
                'Welcome to Eyerizer!',
                style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              const Text(
                'A tool that helps people with colorblindness see colors.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const Text(
                'This app requires camera permission to work.\n Please grant camera permission with the button below to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: ElevatedButton(
      //   onPressed: () {
      //     Application().sharedPreferences.setBool('haveLaunchedBefore', true);
      //     Navigator.pushReplacementNamed(context, '/home');
      //   },
      //   child: const Text('Start'),
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 3.h,
          horizontal: 20.w,
        ),
        child: ElevatedButton(
          onPressed: () {
            Permission.camera.request().whenComplete(() {
              Permission.camera.isGranted.then((value) {
                if (value) {
                  Application().sharedPreferences.setBool('haveLaunchedBefore', true);
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  openAppSettings();
                }
              });
            });
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(30.w, 6.h)),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: AppColors.buttonText,
              fontSize: 16,
            )),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w),
            )),
            backgroundColor: MaterialStateProperty.all(AppColors.buttonBackground),
          ),
          child: const Text(
            'Grant Permission',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
