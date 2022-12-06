import 'package:eyerizer/style/colors.dart';
import 'package:eyerizer/view/colorblind_simulator/colorblind_simulator.view.dart';
import 'package:flutter/material.dart';

class ColorblindSimulatorSplash extends StatelessWidget {
  const ColorblindSimulatorSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ColorblindSimulatorScreen()));
    });
    return const Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Center(
        child: Hero(
          tag: '/colorblind_simulator',
          child: Icon(
            Icons.visibility_outlined,
            size: 48,
            color: AppColors.mainText,
          ),
        ),
      ),
    );
  }
}
