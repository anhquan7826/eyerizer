import 'package:camera/camera.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
import 'package:eyerizer/helper/log_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;

class CameraColorPickerController extends Cubit<CameraColorPickerState> {
  CameraColorPickerController() : super(const CamInitializing()) {
    initialize();
  }

  Future<void> initialize() async {
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

  Future<Color> captureColor() async {
    emit(const CapturingColorStarted());
    final image = await camController.takePicture();
    final bytes = await image.readAsBytes();
    final decodedImage = img.decodeImage(bytes);
    if (decodedImage != null) {
      final color = _abgrToArgb(decodedImage.getPixelSafe((decodedImage.width / 2).round(), (decodedImage.height / 2).round()));
      emit(CapturingColorFinished(color));
      return Color(color);
    } else {
      emit(const CapturingColorError());
      return const Color(0xFFFFFFFF);
    }
  }

  int _abgrToArgb(int argbColor) {
    final r = (argbColor >> 16) & 0xFF;
    final b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  Future<void> pausePreview() async {
    await camController.pausePreview();
  }

  Future<void> resumePreview() async {
    // await camController.resumePreview();
    emit(const CamInitialized());
  }
}
