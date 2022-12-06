import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final appFunction = [
    ['Color Camera', 'Help you see identify colors in your surrounding environment.', '/cam_color_picker', Icons.camera_alt_outlined],
    ['Colorblind Test', 'Help you identify which type of colorblindness you have.', '/color_blind_test', Icons.quiz_outlined],
    ['Colorblind Simulator', 'Know how people with colorblindness see.', '/colorblind_simulator', Icons.visibility_outlined],
    ['Color Picker', 'Get colors from your photos', '/color_picker', Icons.colorize_outlined],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 20.h,
        title: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: const Text(
            'Eyerizer',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: AppColors.mainText,
            ),
          ),
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(3.w),
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        children: appFunction
            .map((e) => card(
                  title: e[0] as String,
                  subtitle: e[1] as String,
                  route: e[2] as String,
                  icon: e[3] as IconData,
                ))
            .toList(),
      ),
    );
  }

  Widget card({required String title, required String subtitle, required String route, required IconData icon}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        margin: EdgeInsets.all(3.w),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppColors.buttonBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Hero(
                tag: route,
                child: Icon(
                  icon,
                  color: AppColors.buttonText,
                  size: 36,
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                    color: AppColors.buttonText,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
            ),
            const Spacer(),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.buttonText,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
