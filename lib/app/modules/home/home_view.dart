import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'home_controller.dart';
import 'item_home_menu.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx(
      (state) => buildUI().p24(),
      onLoading: ExUiLoading(),
      onError: (e) => ExUiErrorOrEmpty(message: "$e", showBtnRetry: true),
    ));
  }

  Widget buildUI() {
    return VStack([
      buildHeader(),
      Expanded(
        child: VStack([
          buildBoxBalance(),
          24.heightBox,
          Expanded(
            child: VStack([
              24.heightBox,
              '-- FITUR --'.text.size(18).bold.make(),
              buildListMenu(),
            ]).scrollVertical(),
          ),
        ]),
      ),
    ]);
  }

  Widget buildHeader() {
    return VStack([
      24.heightBox,
      HStack([
        Obx(() => '${controller.welcomeText}'.text.make()),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.help)),
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none_outlined)),
        // 16.widthBox,
      ]),
      VStack([
        '${controller.dataUser.value.username}'.text.size(18).bold.uppercase.make(),
      ]),
      24.heightBox,
    ]);
  }

  Obx buildListMenu() {
    return Obx(
      () => Container(
        height: 400,
        child: GridView.builder(
          itemCount: controller.menuList.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            mainAxisExtent: 150,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext ctx, index) {
            return OpacityAnimation(
              duration: Duration(milliseconds: 2000),
              child: ItemHomeMenu(
                id: controller.menuList[index]["id"],
                icon: controller.menuList[index]["icon"],
                label: controller.menuList[index]["label"],
                badge: controller.menuList[index]["badge"],
                onPress: () => controller.menuItemClick(
                  controller.menuList[index]["id"],
                  controller.menuList[index]["label"],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container buildBoxBalance() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: controller.commonBoxShadow(fillColor: colorWhite),
      child: HStack([
        // Icon(Icons.wifi_off, color: paleGrey, size: 120),
        LottieBuilder.asset(
          'assets/lottie/home_wifi.json',
          height: 120,
          width: 120,
        ),
        16.widthBox,
        Container(color: paleGrey, width: 0.5, height: 140),
        16.widthBox,
        Expanded(
          child: VStack([
            Spacer(),
            'Saldo anda:'.text.size(16).bold.make().marginOnly(bottom: 4),
            'Rp. ${rupiahFormat(controller.dataUser.value.balance)}'.text.make(),
            Spacer(),
          ]),
        )
      ]).p12(),
    );
  }
}
