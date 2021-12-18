import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ex_reusable/extensions/index.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_avatar_view
///   date                  : 21 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16i090f
///
class ExAvatarView extends StatelessWidget {
  const ExAvatarView({
    Key? key,
    required this.url,
    required this.userFullName,
    this.height,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.textSize,
    this.textColor,
    this.bgColor,
  }) : super(key: key);

  final String url;
  final String userFullName;
  final double? height;
  final double? width;
  final Color? borderColor;
  final double? borderWidth;
  final double? textSize;
  final Color? textColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    var header = {"Referer": "https://mobile.gredu.co/*"};

    return ZStack(
      [
        Container(
          width: height ?? 70,
          height: width ?? 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor ?? Colors.black12, width: borderWidth ?? 2.0),
          ),
          child: ClipOval(
            child: ExtendedImage.network(
              url,
              headers: header,
              width: height ?? 70,
              height: width ?? 70,
              fit: BoxFit.cover,
              cache: true,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              enableMemoryCache: true,
              isAntiAlias: true,
              cacheMaxAge: 7.days,
              retries: 1,
              loadStateChanged: (state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return CupertinoActivityIndicator();
                  case LoadState.completed:
                    return ExtendedRawImage(
                      image: state.extendedImageInfo?.image,
                      width: height ?? 70,
                      fit: BoxFit.cover,
                      height: width ?? 70,
                    );
                  case LoadState.failed:
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        "${userFullName.initialName}"
                            .text
                            .color(textColor ?? Colors.white)
                            .size(textSize ?? 14)
                            .makeCentered()
                            .backgroundColor(bgColor ?? _buildBgColorByName(userFullName.initialName)),
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  // @todo : FIX ME, this ugly -_-
  Color _buildBgColorByName(String initialName) {
    var output;
    switch (initialName.substring(0, 1)) {
      case "A":
        output = Color(0xff5876dc);
        break;
      case "B":
        output = Color(0xffa6daf1);
        break;
      case "C":
        output = Color(0xffb4aa52);
        break;
      case "D":
        output = Color(0xff936b5e);
        break;
      case "E":
        output = Color(0xff8246a7);
        break;
      case "F":
        output = Color(0xffa78346);
        break;
      case "G":
        output = Color(0xffa74646);
        break;
      case "H":
        output = Color(0xff46a780);
        break;
      case "I":
        output = Color(0xff4656a7);
        break;
      case "J":
        output = Color(0xffa446a7);
        break;
      case "K":
        output = Color(0xffa7468c);
        break;
      case "L":
        output = Color(0xff766873);
        break;
      case "M":
        output = Color(0xffabbfab);
        break;
      case "O":
        output = Color(0xff8471a3);
        break;
      case "P":
        output = Color(0xffa071a3);
        break;
      case "Q":
        output = Color(0xffa1a371);
        break;
      case "R":
        output = Color(0xff7176a3);
        break;
      case "S":
        output = Color(0xffa37171);
        break;
      case "T":
        output = Color(0xffa37198);
        break;
      case "U":
        output = Color(0xff8ea371);
        break;
      case "V":
        output = Color(0xff7193a3);
        break;
      case "W":
        output = Color(0xff7189a3);
        break;
      case "X":
        output = Color(0xffa071a3);
        break;
      case "Y":
        output = Color(0xffa37171);
        break;
      case "Z":
        output = Color(0xff7a71a3);
        break;
      default:
        output = Colors.primaries[Random().nextInt(Colors.primaries.length)];
        break;
    }
    return output;
  }
}
