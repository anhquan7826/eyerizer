import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';

class ColorNameCard extends StatelessWidget {
  const ColorNameCard({
    Key? key,
    required this.color,
    required this.name,
    this.radius = 20,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Color color;
  final String name;

  final double radius;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ColoredBox(
              color: AppColors.colorCardBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'This color is: '),
                        TextSpan(
                          text: name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Color code: 0x${color.value.toRadixString(16).toUpperCase()}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
