import 'package:camera/camera.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.controller.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
import 'package:eyerizer/model/color_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  var color = const Color(0xFFFFFFFF);

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
          // if (state is CamInitialized) {
          //   return Column(
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(10),
          //         child: CameraPreview(
          //           controller.camController,
          //           child: crosshair(),
          //         ),
          //       ),
          //       Expanded(
          //         child: GestureDetector(
          //           onTap: () async {
          //             color = await controller.captureColor();
          //             setState(() {});
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: color,
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   );
          // } else {
          //   return Center(
          //     child: Text(state is CamError ? 'Error!' : 'Initializing...'),
          //   );
          // }
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
                      onPressed: () async {
                        color = await controller.captureColor();
                        setState(() {});
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
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: color),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: 'This color is: '),
                                TextSpan(
                                  text: colorNames[color],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text('Color code: 0xFF${color.value.toRadixString(16).toUpperCase()}'),
                          ElevatedButton(
                            onPressed: () {
                              controller.resumePreview();
                            },
                            child: const Text('Continue'),
                          ),
                        ],
                      ),
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
