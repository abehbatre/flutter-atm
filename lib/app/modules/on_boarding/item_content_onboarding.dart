import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_atm/app/common/lifecycle/animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemContentOnBoarding extends GetView {
  final String contentImage;
  final String pictureType;

  const ItemContentOnBoarding({Key? key, required this.contentImage, required this.pictureType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleAnimation(
        initScale: 0.45,
        duration: Duration(milliseconds: 1000),
        child: pictureType == 'svg'
            ? SvgPicture.asset(
                contentImage,
                placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(45),
                  child: const CircularProgressIndicator(),
                ),
              )
            : Image.asset(
                contentImage,
              ).marginAll(20).paddingAll(20).w(300),
      ),
    );
  }
}
