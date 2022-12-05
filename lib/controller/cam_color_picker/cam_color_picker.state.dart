import 'package:equatable/equatable.dart';

abstract class CameraColorPickerState extends Equatable {
  const CameraColorPickerState();
}

class CameraColorPickerInitialState extends CameraColorPickerState {
  const CameraColorPickerInitialState();

  @override
  List<Object?> get props => [];
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
  const CapturingColorFinished(this.name, this.color);

  final int color;
  final String name;

  @override
  List<Object?> get props => [name, color];
}

class CapturingColorError extends CameraColorPickerState {
  const CapturingColorError();

  @override
  List<Object?> get props => [];
}