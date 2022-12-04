import 'package:equatable/equatable.dart';

abstract class ColorblindSimulatorState extends Equatable {
  const ColorblindSimulatorState();
}

class ColorblindSimulatorInitialState extends ColorblindSimulatorState {
  const ColorblindSimulatorInitialState();

  @override
  List<Object?> get props => [];
}

class ColorblindSimulatorCameraInitiatingState extends ColorblindSimulatorState {
  const ColorblindSimulatorCameraInitiatingState();

  @override
  List<Object?> get props => [];
}

class ColorblindSimulatorCameraInitiatedState extends ColorblindSimulatorState {
  const ColorblindSimulatorCameraInitiatedState();

  @override
  List<Object?> get props => [];
}

class ColorblindSimulatorCameraErrorState extends ColorblindSimulatorState {
  const ColorblindSimulatorCameraErrorState();

  @override
  List<Object?> get props => [];
}