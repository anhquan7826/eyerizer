import 'package:equatable/equatable.dart';

abstract class CameraColorPickerState extends Equatable {
  const CameraColorPickerState();
}

class CamInitializing extends CameraColorPickerState {
  const CamInitializing();

  @override
  List<Object?> get props => [];
}

class CamInitialized extends CameraColorPickerState {
  const CamInitialized();

  @override
  List<Object?> get props => [];
}

class CamError extends CameraColorPickerState {
  const CamError();

  @override
  List<Object?> get props => [];
}