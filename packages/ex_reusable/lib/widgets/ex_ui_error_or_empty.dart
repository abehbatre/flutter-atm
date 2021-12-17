import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import 'ex_button_outline.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_ui_error
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16xvzr6

class ExUiErrorOrEmpty extends StatelessWidget {
  const ExUiErrorOrEmpty({
    Key? key,
    required this.message,
    this.callback,
    this.title = '',
    this.bgColor,
    this.textColor,
    this.btnText,
    this.svgAssets,
    this.lottieAssets,
    this.lottieNetwork,
    this.showBtnRetry = false,
    this.textSize = 14,
    this.imageHeight,
    this.imageWidth,
  }) : super(key: key);

  final String message;
  final String title;
  final double? textSize;
  final String? btnText;
  final bool? showBtnRetry;
  final Color? bgColor;
  final Color? textColor;
  final VoidCallback? callback;
  final String? svgAssets;
  final String? lottieAssets;
  final String? lottieNetwork;
  final double? imageHeight;
  final double? imageWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: context.mq.size.height,
      // width: context.mq.size.width,
      child: Container(
        // height: context.mq.size.height,
        // width: context.mq.size.width,
        color: bgColor ?? Colors.transparent,
        child: VStack(
          [
            svgAssets != null
                ? SvgPicture.asset(
                    '$svgAssets',
                    width: imageWidth,
                    height: imageHeight,
                  ).centered()
                : 0.heightBox,
            lottieAssets != null
                ? Lottie.asset(
                    '$lottieAssets',
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.fill,
                  ).centered()
                : 0.heightBox,
            lottieNetwork != null
                ? Lottie.network(
                    '$lottieNetwork',
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.fill,
                  ).centered()
                : 0.heightBox,
            HeightBox(title.isEmptyOrNull ? 0 : 20),
            "$title".text.size(16).semiBold.color(Colors.black).makeCentered(),
            HeightBox(20),
            message.isEmptyOrNull
                ? "Terjadi Kesalahan".text.size(textSize).color(textColor ?? Colors.black).makeCentered()
                : "$message".text.size(textSize).color(textColor ?? Colors.black).align(TextAlign.center).makeCentered(),
            HeightBox(20),
            showBtnRetry == true
                ? ExButtonOutline(
                    btnText: btnText ?? "Reload",
                    color: textColor ?? Colors.black,
                    onPress: callback,
                  ).centered()
                : "".text.make(),
          ],
        ).centered(),
      ),
    );
  }
}
