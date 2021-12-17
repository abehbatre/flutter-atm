import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VStack([
        '${lorem(paragraphs: 1, words: 2)}'.text.color(colorBlack).bold.size(20).make().marginOnly(bottom: 16),
        '${lorem(paragraphs: 1, words: 15)}.'.text.color(colorGrey).size(14).make(),
        24.heightBox,
        ExTextFieldLabeled(tfController: controller.tfUserName, label: 'Username', hint: 'Username'),
        24.heightBox,
        ExButtonDefault(
          btnText: 'Masuk',
          width: double.infinity,
          height: 50,
          onPress: () => controller.doLogin(),
        ),
        32.heightBox,
        HStack([
          Divider(color: Color(0xffD8DCE0)).expand(),
          ' atau '.text.color(Color(0xff676E76)).make().pOnly(left: 8, right: 8),
          Divider(color: Color(0xffD8DCE0)).expand(),
        ]),
        32.heightBox,
        Container(
          decoration: controller.commonBoxDecoration(),
          width: double.infinity,
          height: 50,
          child: HStack([
            Spacer(),
            SvgPicture.asset('assets/images/ic_google_logo.svg'),
            12.widthBox,
            'Masuk dengan Google'.text.extraBold.make(),
            Spacer(),
          ]),
        ),
      ]).p24().scrollVertical(),
      bottomSheet: Container(
        width: double.infinity,
        child: VStack([
          'made with ❤️ by flutter'.text.makeCentered(),
          // 'Klik disini untuk register'.text.underline.color(colorPrimary).makeCentered(),
        ]).p24(),
      ),
    );
  }
}
