import 'package:camera/camera.dart';
import 'package:eyerizer/components/color_name_card.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.controller.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CameraColorPickerScreen extends StatefulWidget {
  const CameraColorPickerScreen({Key? key}) : super(key: key);

  @override
  State<CameraColorPickerScreen> createState() => _CameraColorPickerScreenState();
}

class _CameraColorPickerScreenState extends State<CameraColorPickerScreen> {
  final CameraColorPickerController controller = CameraColorPickerController();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: controller,
      builder: (BuildContext context, state) {
        if (state is CamInitializing) {
          return const Scaffold(
            backgroundColor: AppColors.mainBackground,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.mainBackground,
                color: AppColors.mainText,
              ),
            ),
          );
        } else if (state is CamError) {
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
              title: const Text('Pick colors'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: AppColors.mainBackground,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.w),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CameraPreview(
                          controller.camController,
                          child: crosshair(),
                        ),
                        if (state is CapturingColorFinished)
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: ColorNameCard(
                              color: Color(state.color),
                              name: state.name,
                              width: 60.w,
                              height: 20.h,
                              onClose: controller.closeColorDialog,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        controller.captureColor();
                      },
                      backgroundColor: AppColors.buttonBackground,
                      elevation: 0,
                      child: state is CapturingColorStarted
                          ? const CircularProgressIndicator(
                              backgroundColor: AppColors.buttonBackground,
                              color: AppColors.mainText,
                            )
                          : state is CapturingColorError
                              ? const Icon(
                                  Icons.error_outline_rounded,
                                  size: 36,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.camera),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget crosshair() {
    return Center(
      child: SvgPicture.asset(
        'assets/crosshair2.svg',
        width: 32,
      ),
    );
  }
}
