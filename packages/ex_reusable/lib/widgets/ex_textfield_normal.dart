import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_text_field_normal
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16r3q1c

class ExTextFieldNormal extends StatelessWidget {
  const ExTextFieldNormal({
    Key? key,
    this.borderColor = const Color(0xFFe4e8eb),
    this.hint,
    this.controller,
    this.isPassword,
    this.obscureText,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.enabled,
    this.fillColor = Colors.transparent, this.textInputType, this.textInputAction,
  }) : super(key: key);
  final Color? borderColor;
  final String? hint;
  final TextEditingController? controller;
  final bool? isPassword;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return VxTextField(
      borderType: VxTextFieldBorderType.roundLine,
      borderRadius: 8,
      borderColor: borderColor,
      maxLine: 1,
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
