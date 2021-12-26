import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

///   created               : Aditya Pratama
///   originalFilename      : ex_avatar_view
///   date                  : 21 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   screenshot            : https://prnt.sc/16i090f
class ExImageView extends StatelessWidget {
  const ExImageView({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.radius = 8,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String url;
  final double? height;
  final double? width;
  final Color? borderColor;
  final double? borderWidth;
  final double radius;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    final Map<String, String> header = {'Referer': 'https://mobile.gredu.co/*'};
    return ZStack(
      <Widget>[
        Container(
          width: width ?? 70,
          height: height ?? 70,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.blueGrey, width: borderWidth ?? 0.5),
          ),
          child: ExtendedImage.network(
            url,
            headers: header,
            width: height ?? 70,
            height: width ?? 70,
            fit: BoxFit.cover,
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            isAntiAlias: true,
            cacheMaxAge: 7.days,
            retries: 1,
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return const CupertinoActivityIndicator();
                case LoadState.completed:
                  return ExtendedRawImage(
                    image: state.extendedImageInfo?.image,
                    width: height ?? 70,
                    fit: BoxFit.cover,
                    height: width ?? 70,
                  );
                case LoadState.failed:
                  return GestureDetector(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.network(
                          'https://image.freepik.com/free-vector/glitch-error-404-page_23-2148105404.jpg',
                          fit: BoxFit.cover,
                        ),
                        const Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Text(
                            'load image failed, click to reload',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      state.reLoadImage();
                    },
                  );
              }
            },
          ),
        ).cornerRadius(radius),
      ],
    );
  }
}
