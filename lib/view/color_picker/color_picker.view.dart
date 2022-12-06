import 'dart:typed_data';

import 'package:eyerizer/components/color_name_card.dart';
import 'package:eyerizer/controller/color_picker/color_picker.controller.dart';
import 'package:eyerizer/controller/color_picker/color_picker.state.dart';
import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:measure_size/measure_size.dart';
import 'package:sizer/sizer.dart';

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  State<ColorPickerScreen> createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  final ColorPickerController controller = ColorPickerController();

  double renderWidth = 0;
  double renderHeight = 0;

  double top = 0;
  double left = 0;

  Offset _pos = const Offset(0, 0);

  set pos(Offset newPos) {
    final double x = newPos.dx < 5
        ? 5
        : newPos.dx > renderWidth - 5
            ? renderWidth - 5
            : newPos.dx;
    final double y = newPos.dy < 5
        ? 5
        : newPos.dy > renderHeight - 5
            ? renderHeight - 5
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
    return BlocConsumer(
      bloc: controller,
      listener: (BuildContext context, Object? state) {
        if (state is ColorPickerImagePickedState) {
          setState(() {
            if (state.image != null) {
              image = state.image;
              _pos = Offset.zero;
              renderWidth = 0;
              renderHeight = 0;
              top = 0;
              left = 0;
              color = null;
              name = null;
            }
          });
        }
        if (state is ColorPickerPickColorState) {
          setState(() {
            color = Color(state.color);
            name = state.name;
          });
        }
      },
      buildWhen: (_, state) => state is ColorPickerInitiatingState || state is ColorPickerInitiatedState,
      builder: (BuildContext context, state) {
        if (state is ColorPickerInitiatingState) {
          return const Scaffold(
            backgroundColor: AppColors.mainBackground,
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.mainBackground,
                color: AppColors.mainText,
              ),
            ),
          );
        }
        else {
          return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Color Picker'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (image != null)
                IconButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  icon: const Icon(Icons.image),
                )
            ],
          ),
          backgroundColor: AppColors.mainBackground,
          body: Center(
            child: image == null
                ? ElevatedButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.w),
                        )),
                        minimumSize: MaterialStateProperty.all(Size(40.w, 5.h)),
                        backgroundColor: MaterialStateProperty.all(AppColors.buttonBackground),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                          color: AppColors.buttonText,
                        ))),
                    child: const Text('Pick an image...'),
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 5.w,
                            right: 5.w,
                            bottom: 5.w,
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.w),
                              child: Listener(
                                onPointerMove: (details) {
                                  pos = _pos + details.delta;
                                  calculatePreviewBoxPosition(pos);
                                },
                                onPointerUp: (event) {
                                  controller.calculatePreviewBoxColor(previewPosition: pos, renderWidth: renderWidth, renderHeight: renderHeight);
                                },
                                child: Stack(
                                  children: [
                                    MeasureSize(
                                      onChange: (size) {
                                        renderWidth = size.width;
                                        renderHeight = size.height;
                                      },
                                      child: Image.memory(
                                        image!,
                                        fit: BoxFit.contain,
                                      ),
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
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: (color != null && name != null)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 5.w,
                                  bottom: 5.w,
                                ),
                                child: ColorNameCard(
                                  color: color!,
                                  name: name!,
                                  backgroundColor: AppColors.colorCardBackground,
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
          ),
        );
        }
      },
    );
  }

  void calculatePreviewBoxPosition(Offset position) {
    left = position.dx - (crosshairSize / 2);
    top = position.dy - (crosshairSize / 2);
    setState(() {});
  }
}
