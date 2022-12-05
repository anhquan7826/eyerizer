import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class ColorPickerState extends Equatable {
  const ColorPickerState();
}

class ColorPickerInitialState extends ColorPickerState {
  const ColorPickerInitialState();

  @override
  List<Object?> get props => [];
}

class ColorPickerInitiatingState extends ColorPickerState {
  const ColorPickerInitiatingState();

  @override
  List<Object?> get props => [];
}

class ColorPickerInitiatedState extends ColorPickerState {
  const ColorPickerInitiatedState();

  @override
  List<Object?> get props => [];
}

class ColorPickerImagePickingState extends ColorPickerState {
  const ColorPickerImagePickingState();

  @override
  List<Object?> get props => [];
}

class ColorPickerImagePickedState extends ColorPickerState {
  const ColorPickerImagePickedState(this.image);

  final Uint8List? image;

  @override
  List<Object?> get props => [image];
}

class ColorPickerImagePickingFailedState extends ColorPickerState {
  const ColorPickerImagePickingFailedState();

  @override
  List<Object?> get props => [];
}

class ColorPickerPickColorState extends ColorPickerState {
  const ColorPickerPickColorState(this.color, this.name);

  final int color;
  final String name;

  @override
  List<Object?> get props => [color];
}