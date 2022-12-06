import 'package:eyerizer/controller/colorblind_test/colorblind_test.controller.dart';
import 'package:eyerizer/controller/colorblind_test/colorblind_test.state.dart';
import 'package:eyerizer/model/colorblind_type.dart';
import 'package:eyerizer/model/palate.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class ColorblindTestScreen extends StatefulWidget {
  const ColorblindTestScreen({Key? key}) : super(key: key);

  @override
  State<ColorblindTestScreen> createState() => _ColorblindTestScreenState();
}

class _ColorblindTestScreenState extends State<ColorblindTestScreen> {
  final ColorblindTestController controller = ColorblindTestController();

  String _text = '';

  String get text => _text.replaceAll(RegExp('[^0-9]'), '');

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: controller,
      builder: (context, state) {
        if (state is TestInitiating) {
          return const Scaffold(
            backgroundColor: AppColors.mainBackground,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.mainBackground,
                color: AppColors.mainText,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: AppColors.mainBackground,
            body: () {
              if (state is TestFinish) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.done_outline_outlined,
                        color: AppColors.mainText,
                        size: 42,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        getResult(),
                        style: const TextStyle(
                          color: AppColors.mainText,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10.h,
                              bottom: 5.h,
                            ),
                            child: SizedBox(
                              height: 30.h,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/palates/${controller.currentPalate.file}',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                          if (controller.currentPalate.type == PalateType.number) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    if (text.isNotEmpty) {
                                      controller.submitAnswer(text);
                                    }
                                  },
                                  onChanged: (value) {
                                    _text = value;
                                  },
                                  cursorColor: AppColors.textFieldText,
                                  key: ValueKey(controller.currentPalate.hashCode),
                                  style: const TextStyle(color: AppColors.textFieldText, fontSize: 22),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    // contentPadding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                      maxWidth: 60.w,
                                      maxHeight: 10.h,
                                    ),
                                    hintText: 'Your answer.',
                                    hintStyle: const TextStyle(color: AppColors.textFieldHint, fontSize: 20),
                                    filled: true,
                                    fillColor: AppColors.textFieldBackground,
                                    focusedBorder: inputBorder(),
                                    border: inputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (text.isNotEmpty) {
                                      controller.submitAnswer(text);
                                    }
                                  },
                                  style: submitButtonStyle(),
                                  child: const Text('Submit.'),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            ElevatedButton(
                              onPressed: () {
                                controller.submitAnswer('Nothing.');
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(const TextStyle(
                                  color: AppColors.buttonText,
                                )),
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(AppColors.buttonBackground.withOpacity(0.5)),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.w),
                                )),
                              ),
                              child: const Text('I see nothing.'),
                            ),
                          ] else
                            StaggeredGrid.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.w,
                              children: controller.currentPalate.answers.values.toList().asMap().entries.map((e) {
                                final index = e.key;
                                final value = e.value;
                                return StaggeredGridTile.fit(
                                  crossAxisCellCount:
                                      (index + 1) % 3 == 0 || (index + 1 == controller.currentPalate.answers.values.length && (index + 1) % 3 == 1)
                                          ? 2
                                          : 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.w),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.submitAnswer(value);
                                      },
                                      style: buttonStyle(),
                                      child: Text(value),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }.call(),
          );
        }
      },
    );
  }

  String getResult() {
    switch (controller.result) {
      case ColorblindType.any:
        return "We can't identify your condition!";
      case ColorblindType.normal:
        return 'Congratulation. You have a normal eyesight!';
      case ColorblindType.redGreen:
        return 'You have red-green blindness!';
      case ColorblindType.protanopia:
        return 'You have Protanopia!';
      case ColorblindType.deuteranopia:
        return 'You have Deuteranopia!';
    }
  }

  InputBorder inputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.w),
        borderSide: BorderSide.none,
      );

  ButtonStyle buttonStyle() => ButtonStyle(
        textStyle: MaterialStateProperty.all(const TextStyle(
          color: AppColors.buttonText,
        )),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(Size(20.w, 15.h)),
        backgroundColor: MaterialStateProperty.all(AppColors.buttonBackground),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        )),
      );

  ButtonStyle submitButtonStyle() => ButtonStyle(
        textStyle: MaterialStateProperty.all(const TextStyle(
          color: AppColors.buttonText,
        )),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(Size(20.w, 5.h)),
        backgroundColor: MaterialStateProperty.all(AppColors.buttonBackground),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.w),
        )),
      );
}
