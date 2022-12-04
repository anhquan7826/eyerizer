import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;

import 'abgr_to_argb.dart';

extension OffsetColor on Uint8List {
  int colorFromCenter() {
    final decodedImage = img.decodeImage(this);
    if (decodedImage != null) {
      return abgrToArgb(decodedImage.getPixelSafe((decodedImage.width / 2).round(), (decodedImage.height / 2).round()));
    } else {
      return 0;
    }
  }

  int colorFromOffset(Offset offset) {
    final decodedImage = img.decodeImage(this);
    if (decodedImage != null) {
      return abgrToArgb(decodedImage.getPixelSafe(offset.dx.round(), offset.dy.round()));
    } else {
      return 0;
    }
  }
}