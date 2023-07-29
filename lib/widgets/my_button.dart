import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../utils/extensions.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final double? height;
  final bool isEnabled;
  final Function()? onTap;

  const MyButton({
    required this.title,
    this.onTap,
    this.color = AppColors.purple,
    this.isEnabled = true,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.9, sigmaY: 2.9),
              child: const SizedBox(),
            ),
          ),
        ),
        InkWell(
          onTap: isEnabled ? onTap : null,
          child: Container(
            alignment: Alignment.center,
            height: height ?? 50.height,
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(5, 4),
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(12.width),
            ),
            child: Text(
              title,
              style: AppTextStyles.h2Bold.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
