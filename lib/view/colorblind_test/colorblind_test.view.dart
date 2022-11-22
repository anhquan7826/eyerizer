import 'package:eyerizer/controller/colorblind_test/colorblind_test.controller.dart';
import 'package:eyerizer/controller/colorblind_test/colorblind_test.state.dart';
import 'package:eyerizer/helper/log_helper.dart';
import 'package:eyerizer/model/colorblind_type.dart';
import 'package:eyerizer/model/palate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ColorblindTestScreen extends StatefulWidget {
  const ColorblindTestScreen({Key? key}) : super(key: key);

  @override
  State<ColorblindTestScreen> createState() => _ColorblindTestScreenState();
}

class _ColorblindTestScreenState extends State<ColorblindTestScreen> {
  late final ColorblindTestController controller;

  @override
  void initState() {
    controller = ColorblindTestController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ishihara Test'),
      ),
      body: BlocBuilder(
          bloc: controller,
          builder: (context, state) {
            if (state is TestFinish) {
              return Text(getResult());
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: 35.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset(
                        'assets/palates/${controller.currentPalate.file}',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  if (controller.currentPalate.type == PalateType.number)
                    TextField(
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        controller.submitAnswer(value);
                        LogHelper.log(state);
                      },
                      key: ValueKey(controller.currentPalate.hashCode),
                    )
                  else
                    ...controller.currentPalate.answers.values.map((e) {
                      return ElevatedButton(
                        onPressed: () {
                          controller.submitAnswer(e);
                        },
                        child: Text(e),
                      );
                    }),
                  if (controller.currentPalate.type == PalateType.number)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.submitAnswer('Nothing.');
                        },
                        child: const Text('I see nothing.'),
                      ),
                    ),
                ],
              );
            }
          }),
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
}
