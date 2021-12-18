import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/models/_key_val.dart';
import 'package:flutter_atm/app/repository/local/database.dart';
import 'package:get/get.dart';

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

  showBottomListUser() {
    var listKV = <KeyVal>[];
    listUsers.forEach((element) {
      // exclude current user >> todo : fix me, this ugly way.
      if (element.username != Get.arguments) {
        listKV.add(KeyVal(key: element, val: element.username));
      }
    });
    bottomSheetListDialog(
        listKV: listKV,
        title: 'Daftar Pengguna',
        emptyMessage: 'belum ada data.',
        callback: (k, v) {
          currentSelectedUserObject.value = k;
          currentSelectedUserString.value = v;
        });
  }

  onSubmit() {
    _validation(() async {
      var amount = tfInput.text;
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
  _getListAllUser() async {
    await db.getListUser.then((value) => listUsers.assignAll(value)).catchError((e) {
      snackBarError(message: '$e');
    });
  }

  _validation(Function onNext) {
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
