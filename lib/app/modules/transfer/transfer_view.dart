import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'transfer_controller.dart';

class TransferView extends GetView<TransferController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Transfer'.text.black.make(), centerTitle: false),
      body: VStack([
        'Saldo Anda'.text.color(colorBlack).bold.size(20).make().marginOnly(bottom: 16),
        Obx(() => '${rupiahFormat(controller.dataUser.value.balance)}'.text.make()),
        16.heightBox,
        'Kirim Ke'.text.color(colorBlack).bold.size(20).make().marginOnly(bottom: 16),
        Container(
          decoration: controller.commonBoxDecoration(),
          child: HStack([
            Obx(() => '${controller.currentSelectedUserString}'.text.make()),
            Spacer(),
            Icon(ExIcons.fi_rr_angle_small_down),
          ]).p12(),
        ).onInkTap(() => controller.showBottomListUser()),
        24.heightBox,
        ExTextFieldLabeled(
          tfController: controller.tfInput,
          label: 'Masukkan nilai transfer',
          hint: 'Rp.1.000.0000',
          onChanged: (value) => controller.update(),
        ),
        8.heightBox,
        GetBuilder<TransferController>(
          builder: (controller) {
            return controller.tfInput.text.isNotBlank ? '${rupiahFormat(double.parse(controller.tfInput.text))}'.text.make() : 0.heightBox;
          },
        ),
      ]).p24().scrollVertical(),
      bottomSheet: VStack([
        ExButtonOutline(
          width: double.infinity,
          btnText: 'Kirim',
          height: 50,
          color: colorPrimary,
          onPress: () => controller.onSubmit(),
        ),
      ]).p24(),
    );
  }
}
