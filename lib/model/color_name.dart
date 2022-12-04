import 'dart:math' as math;

import 'package:eyerizer/helper/color_extension.dart';
import 'package:eyerizer/model/colors.dart';
import 'package:flutter/material.dart';

class ColorName {
  factory ColorName() => _instance;

  ColorName._();

  static final ColorName _instance = ColorName._();

  Future<String> getName(Color color) async {
    final r = color.red;
    final g = color.green;
    final b = color.blue;
    final h = color.hue;
    final s = color.saturation;
    final l = color.lightness;

    if (_colorNames(color.value) != null) {
      return _colorNames(color.value)!;
    }
    num df = -1, cl = -1;
    for (int i = 0; i < names.entries.length; i++) {
      final c = Color(int.parse('0xFF${names.entries.elementAt(i).key}'));
      final ndf1 = math.pow(r - c.red, 2) + math.pow(g - c.green, 2) + math.pow(b - c.blue, 2);
      final ndf2 = math.pow(h - c.hue, 2) + math.pow(s - c.saturation, 2) + math.pow(l - c.lightness, 2);
      final ndf = ndf1 + ndf2 * 2;
      if (df < 0 || df > ndf) {
        df = ndf;
        cl = i;
      }
    }

    if (cl < 0) {
      return 'Unknown';
    } else {
      return names.entries.elementAt(cl.round()).value;
    }
  }

  String? _colorNames(int value) {
    return names[value.toRadixString(16).substring(4)];
  }
}
