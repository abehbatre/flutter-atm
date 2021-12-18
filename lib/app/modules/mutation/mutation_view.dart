import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'item_mutation.dart';
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
            itemBuilder: (context, index) => ItemMutation(
              controller: controller,
              i: index,
              itemClick: (data) => controller.showDetail(data),
            ),
          ),
        ),
      ),
      24.heightBox,
    ]);
  }
}
