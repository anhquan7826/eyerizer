import 'package:eyerizer/style/colors.dart';
import 'package:eyerizer/view/colorblind_test/colorblind_test.overview.dart';
import 'package:flutter/material.dart';

class ColorblindTestSplash extends StatelessWidget {
  const ColorblindTestSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ColorblindTestOverview()));
    });
    return const Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Center(
        child: Hero(
          tag: '/color_blind_test',
          child: Icon(
            Icons.quiz_outlined,
            size: 48,
            color: AppColors.mainText,
          ),
        ),
      ),
    );
  }
}
