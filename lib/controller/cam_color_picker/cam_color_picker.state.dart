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

class CapturingColorStarted extends CameraColorPickerState {
  const CapturingColorStarted();

  @override
  List<Object?> get props => [];
}

class CapturingColorFinished extends CameraColorPickerState {
  const CapturingColorFinished(this.color);

  final int color;

  @override
  List<Object?> get props => [color];
}

class CapturingColorError extends CameraColorPickerState {
  const CapturingColorError();

  @override
  List<Object?> get props => [];
}