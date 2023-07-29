import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../utils/extensions.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final TextEditingController? controller;
  final GlobalKey<FormFieldState>? globalKey;
  final bool isError;
  final Color? textColor;
  final Color? borderColor;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const MyTextField({
    required this.hintText,
    super.key,
    this.suffixIcon,
    this.globalKey,
    this.validator,
    this.keyboardType,
    this.isError = false,
    this.controller,
    this.preffixIcon,
    this.inputFormatters,
    this.onChanged,
    this.focus,
    this.onTap,
    this.borderColor = AppColors.primary,
    this.onSubmitted,
    this.textColor,
  });

  BorderRadius get borderRadius => BorderRadius.circular(12.width);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: -4,
                ),
                BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 4),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.gradient5,
              borderRadius: borderRadius,
            ),
          ),
        ),
        TextFormField(
          key: globalKey,
          style: AppTextStyles.p1.copyWith(color: textColor ?? AppColors.white),
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          focusNode: focus,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
            prefixIcon: preffixIcon != null ? preffixIcon! : null,
            suffixIcon: suffixIcon != null
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 18.87.width, 0),
                    child: suffixIcon,
                  )
                : null,
            isDense: true,
            hintStyle: AppTextStyles.p2.copyWith(color: AppColors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: borderRadius,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: borderRadius,
            ),
          ),
        ),
      ],
    );
  }
}
