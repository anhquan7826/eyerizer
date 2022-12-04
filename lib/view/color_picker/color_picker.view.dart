import 'dart:typed_data';

import 'package:eyerizer/components/color_name_card.dart';
import 'package:eyerizer/controller/color_picker/color_picker.controller.dart';
import 'package:eyerizer/controller/color_picker/color_picker.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final ColorPickerController controller = ColorPickerController();

  double top = 0;
  double left = 0;

  Offset _pos = const Offset(0, 0);

  set pos(Offset newPos) {
    final double x = newPos.dx < 0
        ? 0
        : newPos.dx > controller.renderWidth!
            ? controller.renderWidth!
            : newPos.dx;
    final double y = newPos.dy < 0
        ? 0
        : newPos.dy > controller.renderHeight!
            ? controller.renderHeight!
            : newPos.dy;
    _pos = Offset(x, y);
  }

  Offset get pos => _pos;

  final crosshairSize = 5.w;

  Color? color;
  String? name;

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Picker'),
      ),
      body: BlocListener(
        bloc: controller,
        listener: (BuildContext context, state) {
          if (state is ColorPickerPickImageState) {
            setState(() {
              image = state.image;
            });
          }
          if (state is ColorPickerPickColorState) {
            setState(() {
              color = Color(state.color);
              name = state.name;
            });
          }
        },
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                controller.pickImage();
              },
              child: const Text('Pick an image...'),
            ),
            if (image != null) ...[
              Listener(
                onPointerMove: (details) {
                  pos = _pos + details.delta;
                  calculatePreviewBoxPosition(pos);
                },
                onPointerUp: (event) {
                  controller.calculatePreviewBoxColor(pos);
                },
                child: Stack(
                  children: [
                    Image.memory(
                      image!,
                      key: controller.imageKey,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      left: left,
                      top: top,
                      child: SvgPicture.asset(
                        'assets/crosshair2.svg',
                        width: crosshairSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (color != null && name != null)
              ColorNameCard(
                color: color!,
                name: name!,
                width: 80.w,
                height: 40.h,
              ),
          ],
        ),
      ),
    );
  }

  void calculatePreviewBoxPosition(Offset position) {
    left = position.dx - (crosshairSize / 2);
    top = position.dy - (crosshairSize / 2);
    setState(() {});
  }
}
