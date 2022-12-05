import 'package:camera/camera.dart';
import 'package:eyerizer/controller/colorblind_simulator/colorblind_simulator.controller.dart';
import 'package:eyerizer/controller/colorblind_simulator/colorblind_simulator.state.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ColorblindSimulator extends StatefulWidget {
  const ColorblindSimulator({Key? key}) : super(key: key);

  @override
  State<ColorblindSimulator> createState() => _ColorblindSimulatorState();
}

class _ColorblindSimulatorState extends State<ColorblindSimulator> {
  final ColorblindSimulatorController controller = ColorblindSimulatorController();

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
        if (state is ColorblindSimulatorCameraInitiatingState) {
          return const Scaffold(
            backgroundColor: AppColors.mainBackground,
            body: Center(
              child: Hero(
                tag: '/cam_color_picker',
                child: Icon(
                  Icons.visibility_outlined,
                  size: 48,
                  color: AppColors.mainText,
                ),
              ),
            ),
          );
        } else if (state is ColorblindSimulatorCameraErrorState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: AppColors.mainBackground,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: AppColors.mainText,
                  ),
                ),
                Text('Cannot initiate camera view. Please check your permission!'),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Colorblind Simulator'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: AppColors.mainBackground,
            body: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(controller.filterMatrix),
                        child: CameraPreview(
                          controller.cameraController,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    radioButton(type: FilterType.normal, title: 'Normal'),
                    radioButton(type: FilterType.tritanopia, title: 'Tritanopia'),
                    radioButton(type: FilterType.deuteranopia, title: 'Deuteranopia'),
                    radioButton(type: FilterType.protanopia, title: 'Protanopia'),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget radioButton({required FilterType type, required String title}) {
    return Column(
      children: [
        Radio(
          value: type,
          groupValue: controller.filterType,
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.radioChecked;
            } else {
              return AppColors.radioUnchecked;
            }
          }),
          onChanged: (t) {
            setState(() {
              controller.filterType = type;
            });
          },
        ),
        Text(
          title,
          style: TextStyle(
            color: AppColors.mainText,
          ),
        ),
      ],
    );
  }
}
