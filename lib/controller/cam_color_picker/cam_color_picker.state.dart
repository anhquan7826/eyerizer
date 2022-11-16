import 'package:equatable/equatable.dart';

abstract class CameraColorPickerState extends Equatable {
  const CameraColorPickerState();
}

class Initializing extends CameraColorPickerState {
  const Initializing();

  @override
  List<Object?> get props => [];
}

class Initialized extends CameraColorPickerState {
  const Initialized();

  @override
  List<Object?> get props => [];
}

class Error extends CameraColorPickerState {
  const Error();

  @override
  List<Object?> get props => [];
}