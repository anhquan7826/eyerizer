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

class ColorPickerPickImageState extends ColorPickerState {
  const ColorPickerPickImageState(this.image);

  final Uint8List? image;

  @override
  List<Object?> get props => [image];
}

class ColorPickerPickColorState extends ColorPickerState {
  const ColorPickerPickColorState(this.color, this.name);

  final int color;
  final String name;

  @override
  List<Object?> get props => [color];

}