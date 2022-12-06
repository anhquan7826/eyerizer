import 'package:eyerizer/controller/color_picker/color_picker.state.dart';
import 'package:eyerizer/helper/abgr_to_argb.dart';
import 'package:eyerizer/model/color_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ColorPickerController extends Cubit<ColorPickerState> {
  ColorPickerController() : super(const ColorPickerInitialState()) {
    init();
  }

  late final ImagePicker picker;
  img.Image? decodedImage;

  void init() {
    emit(const ColorPickerInitiatingState());
    picker = ImagePicker();
    emit(const ColorPickerInitiatedState());
  }

  Future<void> pickImage() async {
    emit(const ColorPickerImagePickingState());
    final imageBytes = await picker.pickImage(source: ImageSource.gallery).then((value) async => await value?.readAsBytes());
    if (imageBytes != null) {
      decodedImage = img.decodeImage(imageBytes);
      emit(ColorPickerImagePickedState(imageBytes));
    } else {
      emit(const ColorPickerImagePickingFailedState());
    }
  }

  Future<void> calculatePreviewBoxColor({required Offset previewPosition, required double renderWidth, required double renderHeight}) async {
    final offset = Offset(
      (previewPosition.dx * imageWidth!) / renderWidth,
      (previewPosition.dy * imageHeight!) / renderHeight,
    );
    final color = abgrToArgb(decodedImage!.getPixelSafe(offset.dx.floor(), offset.dy.floor()));
    final name = await ColorName().getName(Color(color));
    emit(ColorPickerPickColorState(color, name));
  }

  int? get imageWidth => decodedImage?.width;

  int? get imageHeight => decodedImage?.height;
}
