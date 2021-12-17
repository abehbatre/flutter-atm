import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_text_field_multiline
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16r3ny3

class ExTextFieldMultiline extends StatelessWidget {
  const ExTextFieldMultiline({
    Key? key,
    this.borderColor = const Color(0xFFe4e8eb),
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.enabled,
    this.fillColor = Colors.transparent,
    this.textInputAction,
    this.maxLine = 3,
  }) : super(key: key);
  final Color? borderColor;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return VxTextField(
      borderType: VxTextFieldBorderType.roundLine,
      borderRadius: 8,
      borderColor: borderColor,
      maxLine: maxLine,
      keyboardType: TextInputType.multiline,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      hint: hint,
      enabled: enabled ?? true,
      controller: controller,
      fillColor: fillColor,
    );
  }
}
