import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'item_content_onboarding.dart';
import 'onboarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bg_onboarding.png"), fit: BoxFit.cover),
        ),
        child: ZStack([
          Obx(() => Container(
                width: context.mq.size.width,
                child: controller.contentData.length != 0 ? buildPageView() : Center(child: CircularProgressIndicator()),
              )).hHalf(context).pOnly(top: 60),
          Obx(() => buildTextContent(controller.currentPage.value)).pOnly(top: 420),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.contentData.length, (index) => buildDot(index)),
            ).pOnly(top: 530),
          ),
          ExButtonDefault(
            width: double.infinity,
            btnText: 'Masuk',
            bgColor: colorWhite,
            textColor: colorBlack,
            height: 50,
            textSize: 20,
            onPress: () => controller.goLoginPage(),
          ).pOnly(top: 580),
        ]).p24().scrollVertical(),
      ).whFull(context),
    );
  }

  PageView buildPageView() {
    return PageView.builder(
      itemCount: controller.contentData.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ItemContentOnBoarding(
          contentImage: controller.contentData[index]["contentImage"],
          pictureType: controller.contentData[index]["pictureType"],
        );
      },
      controller: controller.myPageController,
      onPageChanged: (newValue) => controller.currentPage.value = newValue,
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 12),
      height: 10,
      width: controller.currentPage.value == index ? 32 : 10,
      decoration: BoxDecoration(
        color: controller.currentPage.value == index ? colorWhite : colorPrimaryDark,
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(milliseconds: 700),
    );
  }

  AnimatedContainer buildTextContent(int index) {
    String title = controller.contentData[index]["contentTitle"];
    String description = controller.contentData[index]["contentDescription"];
    return AnimatedContainer(
      width: double.infinity,
      child: VStack([
        title.text.size(20).extraBold.white.make().centered(),
        10.heightBox,
        description.text.size(15).align(TextAlign.center).color(Colors.white).make().marginOnly(top: 8).centered(),
      ]),
      duration: Duration(milliseconds: 500),
    );
  }
}
