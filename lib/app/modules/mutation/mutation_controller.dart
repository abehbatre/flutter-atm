import 'package:ex_reusable/ex_reusable.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/lifecycle/_index.dart';
import '../../repository/local/database.dart';

class MutationController extends BaseController with StateMixin<int> {
  final listMutation = <TransactionLog>[].obs;

  @override
  Future<void> onInit() async {
    await _getListTransactionLog();
    super.onInit();
  }

  void deleteAllLog() {
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

  void showDetail(TransactionLog data) {
    if (data.description.contains('transfer')) {
      bottomSheetContentDialog(
        title: 'Detail Transaksi',
        childrenWidget: VStack([
          'Waktu transaksi : ${data.createAt.toStringEx(format: 'dd MMM yyyy | HH:mm')}'.text.make(),
          8.heightBox,
          'dari : ${data.from}'.text.make(),
          'ke : ${data.to}'.text.make(),
          8.heightBox,
          'jumlah : ${rupiahFormat(data.amount)}'.text.make(),
          16.heightBox,

        ]),
      );
    } else {
      bottomSheetContentDialog(
        title: 'Detail Transaksi',
        childrenWidget: VStack([
          'Waktu transaksi : ${data.createAt.toStringEx(format: 'dd MMM yyyy | HH:mm')}'.text.make(),
          8.heightBox,
          'Jumlah : ${rupiahFormat(data.amount)}'.text.make(),
          16.heightBox,
        ]),
      );
    }

  }

  // —————————————————————————————————————————————————————————————————————————
  // Private Func
  // —————————————————————————————————————————————————————————————————————————
  Future<void> _getListTransactionLog() async {
    final String currentUser = Get.arguments as String;
    await db.getListTransactionLogByUsername(currentUser).then((value) {
      if (value.isEmpty) {
        change(0, status: RxStatus.empty());
      } else {
        listMutation.assignAll(value);
        change(200, status: RxStatus.success());
      }
    }).catchError((e) {
      change(0, status: RxStatus.empty());
    });
  }
}
