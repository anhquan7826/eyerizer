import 'package:eyerizer/style/colors.dart';
import 'package:eyerizer/view/colorblind_test/colorblind_test.view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ColorblindTestOverview extends StatelessWidget {
  const ColorblindTestOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      appBar: AppBar(
        title: const Text(
          'Ishihara Test',
          style: TextStyle(
            color: AppColors.mainText,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Hero(
                tag: '/color_blind_test',
                child: Icon(
                  Icons.quiz_outlined,
                  size: 48,
                  color: AppColors.mainText,
                ),
              ),
              SizedBox(height: 10.h,),
              const Text(
                "You have to enter the number(s) or choose the description for each plate you can see. If you don't see anything, just click 'I see nothing.'.\n"
                "There will be 38 plates. Press 'Start' to begin.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mainText,
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 3.h,
          horizontal: 30.w,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ColorblindTestScreen()));
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(30.w, 6.h)),
            textStyle: MaterialStateProperty.all(const TextStyle(
              color: AppColors.buttonText,
              fontSize: 18,
            )),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.w),
            )),
            backgroundColor: MaterialStateProperty.all(AppColors.buttonBackground),
          ),
          child: const Text('Start'),
        ),
      ),
    );
  }
}
