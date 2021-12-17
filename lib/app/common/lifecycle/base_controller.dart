import 'package:flutter_atm/app/constants/_shared_preference_key.dart';
import 'package:flutter_atm/app/repository/local/database.dart';
import 'package:get/get.dart';

import 'common_widgets.dart';
import 'picker_widgets.dart';

///   created               : Aditya Pratama
///   originalFilename      : base_controller
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///  abstraction class from [GetxController]
///  write all methods which will be used on controller !

abstract class BaseController extends GetxController with CommonWidgets, PickerWidgets {
  // COMMON VARIABLE
  final _error = ''.obs;
  get error => _error.value;
  set error(val) => _error.value = val;

  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(val) => _isLoading.value = val;

  // DATABASE
  final db = Get.find<MyDatabase>();
  final dataUser = User(balance: 0, createAt: DateTime.now(), username: '').obs;

  getCurrentUser() => db.getUserByUsername(pref.read(PREF_CURRENT_USER)).listen((user) => dataUser.value = user);

}
