import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_button_default
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16i0dic

class ExButtonDefault extends StatelessWidget {
  const ExButtonDefault({
    Key? key,
    required this.btnText,
    this.onPress,
    this.width,
    this.height,
    this.bgColor,
    this.textColor,
    this.textSize,
    this.radius,
  }) : super(key: key);
  final double? width;
  final double? height;
  final String btnText;
  final Color? bgColor;
  final Color? textColor;
  final VoidCallback? onPress;
  final double? textSize;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: onPress ?? (){},
          style: ElevatedButton.styleFrom(
              primary: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 8),
              )),
          child: btnText.text
              .textStyle(TextStyle(color: textColor))
              .size(textSize ?? 15)
              .make()),
    );
  }
}
