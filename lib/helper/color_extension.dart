import 'dart:math' as Math;
import 'package:flutter/material.dart';

extension HSL on Color {
  int get hue {
    final r = red / 255;
    final g = green / 255;
    final b = blue / 255;

    double min = 0, max = 0, delta = 0;

    min = Math.min<double>(r, Math.min(g, b));
    max = Math.max<double>(r, Math.max(g, b));
    delta = max - min;

    double h = 0;
    if (delta > 0) {
      if (max == r && max != g) {
        h += (g - b) / delta;
      }
      if (max == g && max != b) {
        h += 2 + (b - r) / delta;
      }
      if (max == b && max != r) {
        h += 4 + (r - g) / delta;
      }
      h /= 6;
    }
    return (h * 255).round();
  }

  int get saturation {
    final r = red / 255;
    final g = green / 255;
    final b = blue / 255;

    double min = 0, max = 0, delta = 0;

    min = Math.min<double>(r, Math.min(g, b));
    max = Math.max<double>(r, Math.max(g, b));
    delta = max - min;
    final double l = (min + max) / 2;

    double s = 0;
    if (l > 0 && l < 1) {
      s = delta / (l < 0.5 ? (2 * l) : (2 - 2 * l));
    }
    return (s * 255).round();
  }

  int get lightness {
    final r = red / 255;
    final g = green / 255;
    final b = blue / 255;

    double min = 0, max = 0;

    min = Math.min<double>(r, Math.min(g, b));
    max = Math.max<double>(r, Math.max(g, b));
    final double l = (min + max) / 2;

    return (l * 255).round();
  }
}
