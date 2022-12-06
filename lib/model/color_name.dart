import 'dart:math' as math;

import 'package:eyerizer/helper/color_extension.dart';
import 'package:eyerizer/helper/log_helper.dart';
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

    LogHelper.log(color.value.toRadixString(16));
    LogHelper.log('$r $g $b $h $s $l');

    if (_colorNames(color.value) != null) {
      return _colorNames(color.value)!;
    }
    num df = -1, cl = -1;
    for (int i = 0; i < names.length; i++) {
      final c = Color(int.parse('0xFF${names.elementAt(i).first}'));
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
      return names[cl.round()].last;
    }
  }

  String? _colorNames(int value) {
    String? result;
    try {
      result = names.firstWhere((element) => element.contains(value.toRadixString(16).substring(4))).last;
    } catch (_) {
      result = null;
    }
    return result;
  }
}
