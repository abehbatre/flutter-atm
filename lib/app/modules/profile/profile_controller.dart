import 'dart:io';

import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/constants/_shared_preference_key.dart';
import 'package:flutter_atm/app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_atm/app/modules/home/home_controller.dart';
import 'package:flutter_atm/app/modules/mutation/mutation_controller.dart';
import 'package:flutter_atm/app/modules/transfer/transfer_controller.dart';
import 'package:flutter_atm/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController with StateMixin<int> {
  final currentPhoto = ''.obs;
  final currentPhotoUrl = ''.obs;
  File? changePhoto;

  @override
  void onInit() async {
    await getCurrentUser();
    change(0,status: RxStatus.success());
    super.onInit();
  }

  resetDB() async {
    await db.deleteAllTransactionLog();
    await db.deleteAllUser();
    snackBarSuccess(message: 'all DB deleted, please logout');
  }

  logout() async {
    alertDialogConfirmation(
      title: 'Konfirmasi',
      message: 'apakah kamu yakin ingin logout?',
      btnYesText: 'Yap',
      onYesCallback: () async {
        await pref.erase();
        await Get.delete<HomeController>(force: true);
        await Get.delete<ProfileController>(force: true);
        await Get.delete<DashboardController>(force: true);
        await Get.delete<MutationController>(force: true);
        await Get.delete<TransferController>(force: true);
        await Get.offAllNamed(Routes.ON_BOARDING);
      },
    );
  }

  test() {
    db.countUsers.call().listen((event) {
      logW("test : ${event.data.values.toList()[0]}");
    });
  }
}
