import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/constants/_shared_preference_key.dart';
import 'package:flutter_atm/app/repository/local/database.dart';
import 'package:get/get.dart';

class MutationController extends BaseController with StateMixin<int> {
  final listMutation = <TransactionLog>[].obs;

  @override
  Future<void> onInit() async {
    await _getListTransactionLog();
    super.onInit();
  }

  deleteAllLog() {
    alertDialogConfirmation(
      title: 'Konfirmasi',
      message: 'apakah anda yakin ingin menghapus seluruh mutasi?',
      onYesCallback: () async {
        await db.deleteAllTransactionLog().then((value) {
          Get.back();
          snackBarSuccess(message: 'log transaksi telah di hapus');
          onInit();
        });
      },
    );
  }

  // —————————————————————————————————————————————————————————————————————————
  // Private Func
  // —————————————————————————————————————————————————————————————————————————
  _getListTransactionLog() async {
    var currentUser = pref.read(PREF_CURRENT_USER);
    await db.getListTransactionLogByUsername(currentUser).then((value) {
      if (value.length == 0) {
        change(0, status: RxStatus.empty());
      } else {
        listMutation.assignAll(value);
        change(200, status: RxStatus.success());
      }
    }).catchError((e) {
      snackBarError(message: '$e');
    });
  }
}
