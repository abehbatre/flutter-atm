import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/resource/_index.dart';
import 'home_controller.dart';

class ItemHomeMenu extends StatelessWidget {
  const ItemHomeMenu({
    Key? key,
    this.id,
    required this.icon,
    required this.label,
    this.badge = false,
    required this.onPress,
  }) : super(key: key);

  final int? id;
  final String? icon;
  final String label;
  final bool badge;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      decoration: controller.commonBoxDecoration(borderColor: scaffoldBackgroundColor, fillColor: scaffoldBackgroundColor),
      child: VStack([
        Image.asset('$icon', width: 82, height: 82),
        12.heightBox,
        Expanded(
          child: Row(children: [
            Container(
              decoration: controller.commonBoxDecoration(radius: 90, fillColor: Vx.red500, borderColor: Vx.red500),
              width: 10,
              height: 10,
            ),
            12.widthBox,
            label.text.semiBold.make().expand(),
          ]),
        ),
      ]).p12().onInkTap(() => onPress.call()),
    );
  }
}
