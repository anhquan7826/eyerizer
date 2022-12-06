import 'package:camera/camera.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
import 'package:eyerizer/helper/abgr_to_argb.dart';
import 'package:eyerizer/helper/log_helper.dart';
import 'package:eyerizer/helper/offset_color.dart';
import 'package:eyerizer/model/color_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraColorPickerController extends Cubit<CameraColorPickerState> {
  CameraColorPickerController() : super(const CameraColorPickerInitialState()) {
    initialize();
  }

  Future<void> initialize() async {
    emit(const CamInitializing());
    try {
      final cameras = await availableCameras();
      camController = CameraController(cameras.first, ResolutionPreset.max, enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
      await camController.initialize();
      emit(const CamInitialized());
    } on CameraException catch (e) {
      LogHelper.log(e);
      emit(const CamError());
    }
  }

  @override
  Future<void> close() {
    camController.dispose();
    return super.close();
  }

  late final CameraController camController;

  Future<void> captureColor() async {
    emit(const CapturingColorStarted());
    final image = await camController.takePicture();
    final bytes = await image.readAsBytes();
    final color = bytes.colorFromCenter();
    if (color != 0) {
      final rgbColor = abgrToArgb(color);
      final name = await ColorName().getName(Color(rgbColor));
      emit(CapturingColorFinished(name, color));
    } else {
      emit(const CapturingColorError());
    }
  }

  Future<void> pausePreview() async {
    await camController.pausePreview();
  }

  Future<void> resumePreview() async {
    // await camController.resumePreview();
    emit(const CamInitialized());
  }

  void closeColorDialog() {
    emit(const CamInitialized());
  }
}
