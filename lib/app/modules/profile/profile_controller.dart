import 'dart:io';

import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/constants/_shared_preference_key.dart';
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

  logout() async {
    alertDialogConfirmation(
      title: 'Konfirmasi',
      message: 'apakah kamu yakin ingin logout?',
      btnYesText: 'Yap',
      onYesCallback: () async {
        pref.erase();
        Get.offAllNamed(Routes.ON_BOARDING);
      },
    );
  }

  test() {
    logW("test :");
  }
}
