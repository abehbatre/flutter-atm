import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'ex_progress.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_dashline
///   date                  : 24 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot           : https://prnt.sc/16i0134

class ExDashLine extends StatelessWidget {
  const ExDashLine({
    Key? key,
    this.width,
    this.color,
  }) : super(key: key);

  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: width ?? 30,
            height: 2,
            child: ExProgress(
              value: 100,
              color1: color ?? Colors.blueGrey,
              color2: color ?? Colors.blueGrey,
            ),
          ),
        ),
        HeightBox(3),
        Center(
          child: Container(
            width: width ?? 30,
            height: 2,
            child: ExProgress(
              value: 100,
              color1: color ?? Colors.blueGrey,
              color2: color ?? Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
