import 'package:camera/camera.dart';
import 'package:eyerizer/controller/colorblind_simulator/colorblind_simulator.state.dart';
import 'package:eyerizer/model/colorblind_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FilterType {
  normal,
  tritanopia,
  deuteranopia,
  protanopia,
}

class ColorblindSimulatorController extends Cubit<ColorblindSimulatorState> {
  ColorblindSimulatorController() : super(const ColorblindSimulatorInitialState()) {
    initCamera();
  }

  late final CameraController cameraController;

  FilterType filterType = FilterType.normal;

  Future<void> initCamera() async {
    emit(const ColorblindSimulatorCameraInitiatingState());
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        emit(const ColorblindSimulatorCameraErrorState());
        return;
      }
      cameraController = CameraController(cameras.first, ResolutionPreset.max, enableAudio: false);
      await cameraController.initialize();
      emit(const ColorblindSimulatorCameraInitiatedState());
    } on CameraException catch (_) {
      emit(const ColorblindSimulatorCameraErrorState());
    }
  }

  @override
  Future<void> close() async {
    cameraController.dispose();
    super.close();
  }

  List<double> get filterMatrix {
    switch (filterType) {
      case FilterType.normal:
        return ColorblindFilter.normal;
      case FilterType.tritanopia:
        return ColorblindFilter.tritanopia;
      case FilterType.deuteranopia:
        return ColorblindFilter.deuteranopia;
      case FilterType.protanopia:
        return ColorblindFilter.protanopia;
    }
  }
}
