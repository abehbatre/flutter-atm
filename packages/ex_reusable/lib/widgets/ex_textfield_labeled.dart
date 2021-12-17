import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_text_field_labeled
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16r3fmj

class ExTextFieldLabeled extends StatelessWidget {
  const ExTextFieldLabeled({
    Key? key,
    this.tfController,
    this.textInputAction,
    this.onSubmitted,
    this.textColor,
    this.hint,
    this.isPassword,
    this.obscureText,
    this.borderRadius,
    this.borderColor,
    required this.label,
    this.labelSize,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController? tfController;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final Color? textColor;
  final String? hint;
  final bool? isPassword;
  final bool? obscureText;
  final double? borderRadius;
  final Color? borderColor;
  final String label;
  final double? labelSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? const Color(0xFFe4e8eb),),
        borderRadius: BorderRadius.circular(borderRadius ?? 11),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white54,
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(0.00, 0.55)
          )
        ],
      ),
      child: VStack([
        "$label".text.size(labelSize ?? 13).color(Color(0xff9fa5aa)).make(),
        VxTextField(
          borderType: VxTextFieldBorderType.none,
          fillColor: Colors.white,
          isPassword: isPassword ?? false,
          obscureText: obscureText ?? false,
          hint: hint,
          style: TextStyle(color: textColor ?? Colors.black),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          controller: tfController,
          onSubmitted: onSubmitted,
        ),
      ]).pOnly(top: 16, left: 16, bottom: 8, right: 16),
    );
  }
}
