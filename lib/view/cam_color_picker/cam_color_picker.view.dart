import 'package:camera/camera.dart';
import 'package:eyerizer/components/color_name_card.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.controller.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick colors'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder(
        bloc: controller,
        builder: (BuildContext context, state) {
          if (state is CamInitializing) {
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Initializing Camera color picker...'),
                ],
              ),
            );
          } else if (state is CamError) {
            return Column(
              children: const [
                Icon(
                  Icons.error_outline_rounded,
                  size: 36,
                  color: Colors.red,
                ),
                Text('Cannot initiate camera view. Please check your permission!'),
              ],
            );
          } else {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CameraPreview(
                    controller.camController,
                    child: crosshair(),
                  ),
                ),
                if (state is CamInitialized)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.captureColor();
                      },
                      child: const Text('Capture'),
                    ),
                  )
                else if (state is CapturingColorStarted)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (state is CapturingColorError)
                  Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 36,
                          color: Colors.red,
                        ),
                        Text('Cannot capture color. Please check your permission!'),
                      ],
                    ),
                  )
                else if (state is CapturingColorFinished)
                  Expanded(
                    child: ColorNameCard(
                      color: Color(state.color),
                      name: state.name,
                      width: 80.w,
                      height: 40.h,
                    ),
                  )
              ],
            );
          }
        },
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
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
