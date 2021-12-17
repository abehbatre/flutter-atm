import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_button_outline
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16i0dic

class ExButtonOutline extends StatelessWidget {
  const ExButtonOutline({
    Key? key,
    this.width,
    this.height,
    required this.btnText,
    this.onPress,
    required this.color,
    this.radius,
    this.textSize,
    this.bgColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String btnText;
  final VoidCallback? onPress;
  final Color color;
  final Color? bgColor;
  final double? radius;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: OutlinedButton(
          onPressed: onPress,
          style: OutlinedButton.styleFrom(
              primary: color,
              backgroundColor: bgColor ?? Colors.white,
              side: BorderSide(color: color),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 8),
              )),
          child: btnText.text.color(color == Colors.transparent ? Colors.black : color).size(textSize ?? 15).make()),
    );
  }
}
