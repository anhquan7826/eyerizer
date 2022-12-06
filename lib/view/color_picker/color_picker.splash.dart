import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';

import 'color_picker.view.dart';

class ColorPickerSplash extends StatelessWidget {
  const ColorPickerSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ColorPickerScreen()));
    });
    return const Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Center(
        child: Hero(
          tag: '/color_picker',
          child: Icon(
            Icons.colorize_outlined,
            size: 48,
            color: AppColors.mainText,
          ),
        ),
      ),
    );
  }
}
