import 'package:camera/camera.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.controller.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraColorPickerScreen extends StatefulWidget {
  const CameraColorPickerScreen({Key? key}) : super(key: key);

  @override
  State<CameraColorPickerScreen> createState() => _CameraColorPickerScreenState();
}

class _CameraColorPickerScreenState extends State<CameraColorPickerScreen> {
  late final CameraColorPickerController controller;

  @override
  void initState() {
    controller = CameraColorPickerController();
    super.initState();
  }

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
          if (state is CamInitialized) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CameraPreview(controller.camController),
            );
          } else {
            return Center(
              child: Text(state is CamError ? 'Error!' : 'Initializing...'),
            );
          }
        },
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
