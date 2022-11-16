import 'package:camera/camera.dart';
import 'package:eyerizer/controller/cam_color_picker/cam_color_picker.state.dart';
import 'package:eyerizer/helper/log_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraColorPickerController extends Cubit<CameraColorPickerState> {
  CameraColorPickerController() : super(const Initializing()) {
    initialize();
  }
  
  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();
      camController = CameraController(cameras.first, ResolutionPreset.max, enableAudio: false);
      await camController.initialize();
      emit(const Initialized());
    } on CameraException catch (e) {
      LogHelper.log(e);
      emit(const Error());
    }
  }

  @override
  Future<void> close() {
    camController.dispose();
    return super.close();
  }
  
  late final CameraController camController;
}