import 'package:ex_reusable/ex_reusable.dart';
import 'package:get/get.dart';

import '../../constants/_shared_preference_key.dart';
import '../../repository/local/database.dart';
import 'common_widgets.dart';
import 'picker_widgets.dart';

///   created               : Aditya Pratama
///   originalFilename      : base_controller
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///  abstraction class from [GetxController]
///  write all methods which will be used on controller !

abstract class BaseController extends GetxController with CommonWidgets, PickerWidgets {
  // DATABASE
  final MyDatabase db = Get.find<MyDatabase>();
  final Rx<User> dataUser = User(balance: 0, createAt: DateTime.now(), username: '').obs;

  Future<void> getCurrentUser() async {
    String? currentUser = '';
    try {
      currentUser = Get.arguments as String;
    } catch (e) {
      currentUser = pref.read(PREF_CURRENT_USER);
    }
    logW('getCurrentUser : [$currentUser]');
    db.getUserByUsername(currentUser!).listen((User user) => dataUser.value = user);
  }
}
