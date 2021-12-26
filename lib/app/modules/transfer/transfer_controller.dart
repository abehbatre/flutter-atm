import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/lifecycle/_index.dart';
import '../../models/_key_val.dart';
import '../../repository/local/database.dart';

class TransferController extends BaseController {
  final tfInput = TextEditingController();
  final listUsers = <User>[].obs;
  final currentSelectedUserString = '-- Pilih Pengguna --'.obs;
  final currentSelectedUserObject = User(username: '', balance: 0, createAt: DateTime.now()).obs;

  @override
  void onInit() {
    getCurrentUser();
    _getListAllUser();
    super.onInit();
  }

  void showBottomListUser() {
    final listKV = <KeyVal>[];
    for (final element in listUsers) {
      // exclude current user >> todo : fix me, this ugly way.
      if (element.username != Get.arguments) {
        listKV.add(KeyVal(key: element, val: element.username));
      }
    }
    bottomSheetListDialog(
        listKV: listKV,
        title: 'Daftar Pengguna',
        emptyMessage: 'belum ada data.',
        callback: (k, v) {
          currentSelectedUserObject.value = k as User;
          currentSelectedUserString.value = v as String;
        });
  }

  void onSubmit() {
    _validation(() async {
      final amount = tfInput.text;
      await db.transfer(dataUser.value, currentSelectedUserObject.value, double.parse(amount)).then((value) {
        // reset state
        currentSelectedUserString.value = '-- Pilih Pengguna --';
        currentSelectedUserObject.value = User(username: '', balance: 0, createAt: DateTime.now());
        tfInput.text = '';
      }).onError((e, stackTrace) {
        snackBarError(message: '$e');
      });
    });
  }

  // —————————————————————————————————————————————————————————————————————————
  // Private Func
  // —————————————————————————————————————————————————————————————————————————
  Future<void> _getListAllUser() async {
    await db.getListUser.then((value) => listUsers.assignAll(value)).catchError((e) {
      snackBarError(message: '$e');
    });
  }

  void _validation(Function() onNext) {
    if (currentSelectedUserString.value.contains('-- Pilih Pengguna --')) {
      snackBarError(message: 'target pengguna harus dimasukkan');
      return;
    }
    if (tfInput.text.isBlank!) {
      snackBarError(message: 'jumlah transfer harus dimasukkan');
      return;
    }

    if (double.parse(tfInput.text) <= 0) {
      snackBarError(message: 'jumlah transfer tidak boleh 0');
      return;
    }
    onNext.call();
  }
}
