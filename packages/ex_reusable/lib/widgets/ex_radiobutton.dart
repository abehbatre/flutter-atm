import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Fadqurrosyidik
///   originalFilename      : ex_checkbox
///   date                  : 27 Aug 2021
///   —————————————————————————————————————————————————————————————————————————————
///

class ExRadioButton extends StatelessWidget {
  const ExRadioButton({
    Key? key,
    this.value,
    this.data,
    required this.title,
    required this.onPress,
    this.isBorder = false,
    this.isBadge = false
  }) : super(key: key);

  final dynamic value;
  final dynamic data;
  final String title;
  final void Function(dynamic) onPress;
  final bool isBorder;
  final bool isBadge;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        dense: true,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isBorder ? BorderSide(color: value == data ? Color(0xFF72a065) : Color(0xffdddddd), width: value == data ? 2 : 1) : BorderSide(color: Colors.transparent)),
        activeColor: Color(0xFF72a065),
        title: HStack([
          title.text.bodyText1(context).color(Color(0xFF333333)).make(),
          8.widthBox,
          isBadge ? VxBadge(
            child: 30.heightBox,
            size: 8,
            color: Vx.red600,
            position: VxBadgePosition.right,
          ) : 0.widthBox
        ]),
        value: value,
        groupValue: data,
        onChanged: onPress);
  }
}