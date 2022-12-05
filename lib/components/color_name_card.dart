import 'package:eyerizer/style/colors.dart';
import 'package:flutter/material.dart';

class ColorNameCard extends StatelessWidget {
  const ColorNameCard({
    Key? key,
    required this.color,
    required this.name,
    this.radius = 20,
    this.shadow = false,
    this.width,
    this.height,
    this.onTap,
    this.onClose,
    this.backgroundColor = AppColors.mainBackground,
    this.textColor = AppColors.mainText,
  }) : super(key: key);

  final Color color;
  final String name;

  final double radius;
  final bool shadow;

  final double? width;
  final double? height;

  final Function()? onTap;
  final Function()? onClose;

  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              boxShadow: shadow
                  ? const [
                      BoxShadow(
                        spreadRadius: 3,
                        blurRadius: 20,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                Flexible(
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      color: color,
                    ),
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
                ColoredBox(
                  color: backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
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
                          style: TextStyle(
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Hex value: 0x${color.value.toRadixString(16).toUpperCase()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                            height: 1.8,
                          ),
                        ),
                        Text(
                          'RGB: (${color.red}, ${color.green}, ${color.blue})',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (onClose != null)
            IconButton(
              onPressed: onClose,
              icon: const CircleAvatar(
                backgroundColor: AppColors.mainBackground,
                child: Icon(
                  Icons.close,
                  color: AppColors.mainText,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
