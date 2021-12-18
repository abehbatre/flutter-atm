import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/constants/_shared_preference_key.dart';
import 'package:flutter_atm/app/repository/local/database.dart';
import 'package:flutter_atm/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final tfUserName = TextEditingController();
  final listUsers = <User>[].obs;

  @override
  Future<void> onInit() async {
    await db.getListUser.then((value) => listUsers.assignAll(value)).catchError((e) {
      snackBarError(message: '$e');
    });
    super.onInit();
  }

  /**
   * doLogin
   * —————————————————————————————————————————————————————————————————————————————
   * flow :
   * - validasi textField yg di input user.
   * - check user di db, kalo belum ada insert, kalo uda ada lanjut ke dashboard...
   */
  doLogin() async {
    _validation(() async {
      // GET_USER
      db.getUserByUsername(tfUserName.text).listen((event) async {
        // pref.write(PREF_IS_LOGIN, true);
        await pref.write(PREF_CURRENT_USER, tfUserName.text);
        Get.offAndToNamed(Routes.DASHBOARD);
      }).onError((e) async {
        // INSERT
        var user = UsersCompanion.insert(
          username: tfUserName.text, // pk
          balance: 0,
          createAt: DateTime.now(),
        );
        await db.createUser(user).then((value) async {
          await pref.write(PREF_CURRENT_USER, tfUserName.text);
          Get.offAndToNamed(Routes.DASHBOARD);
        });
      });
    });
  }

  _validation(Function onNext) {
    if (tfUserName.text.isBlank!) {
      snackBarError(message: 'Field Username harus diisi');
      return;
    }
    if (tfUserName.text.length < 6) {
      snackBarError(message: 'Field Username minimal 6 digit');
      return;
    }
    onNext.call();
  }
}
