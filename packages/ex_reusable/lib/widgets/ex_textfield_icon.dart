import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_text_field_icon
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16r3inj

class ExTextFieldIcon extends StatelessWidget {
  const ExTextFieldIcon({
    Key? key,
    required this.icon,
    this.borderColor = const Color(0xFFe4e8eb),
    this.hint,
    this.controller,
    this.isPassword,
    this.obscureText,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.enabled,
    this.fillColor = Colors.transparent,
    this.iconColor,
    this.textInputType,
    this.textInputAction,
  }) : super(key: key);
  final IconData icon;
  final Color? iconColor;
  final Color? borderColor;
  final String? hint;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final Color? fillColor;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return VxTextField(
      borderType: VxTextFieldBorderType.roundLine,
      borderRadius: 8,
      borderColor: borderColor,
      maxLine: 1,
      prefixIcon: HStack([
        16.widthBox,
        Icon(icon, size: 20, color: iconColor),
        12.widthBox,
        Container(color: borderColor, height: 40, width: 1),
        16.widthBox,
      ]),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      hint: hint,
      enabled: enabled ?? true,
      controller: controller,
      isPassword: isPassword ?? false,
      obscureText: obscureText ?? false,
      fillColor: fillColor,
    );
  }
}
