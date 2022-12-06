import 'package:eyerizer/style/colors.dart';
import 'package:eyerizer/view/cam_color_picker/cam_color_picker.view.dart';
import 'package:flutter/material.dart';

class CameraColorPickerSplash extends StatelessWidget {
  const CameraColorPickerSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CameraColorPickerScreen()));
    });
    return const Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Center(
        child: Hero(
          tag: '/cam_color_picker',
          child: Icon(
            Icons.camera_alt_outlined,
            size: 48,
            color: AppColors.mainText,
          ),
        ),
      ),
    );
  }
}
