import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:get/get.dart';
import 'package:mock_data/mock_data.dart';
import 'package:velocity_x/velocity_x.dart';

import 'mutation_controller.dart';

class MutationView extends GetView<MutationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: 'Mutasi'.text.black.make(),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(ExIcons.fi_rr_trash, color: colorPrimary),
              onPressed: () => controller.deleteAllLog(),
            ),
          ],
        ),
        body: controller.obx(
          (state) => buildUI().p24(),
          onLoading: ExUiLoading(),
          onError: (e) => ExUiErrorOrEmpty(message: "$e", showBtnRetry: true),
          onEmpty: ExUiErrorOrEmpty(lottieAssets: 'assets/lottie/empty_1.json', message: "Tidak ada data"),
        ));
  }

  VStack buildUI() {
    return VStack([
      Expanded(
        child: Obx(
          () => ListView.builder(
            itemCount: controller.listMutation.length,
            itemBuilder: (context, index) => buildItem(controller, index),
          ),
        ),
      ),
      24.heightBox,
    ]);
  }

  Widget buildItem(MutationController controller, i) {
    return Container(
      decoration: controller.commonBoxDecoration(),
      child: VStack([
        'Waktu: ${controller.listMutation[i].createAt}'.text.make(),
        'Deskripsi: ${controller.listMutation[i].description}'.text.make(),
        8.heightBox,
        'Amount: Rp. ${rupiahFormat(controller.listMutation[i].amount)}'.text.make(),
        'Referensi: ${mockUUID()}'.text.make(),
      ]).p12(),
    ).pOnly(top: 8, bottom: 8);
  }
}
