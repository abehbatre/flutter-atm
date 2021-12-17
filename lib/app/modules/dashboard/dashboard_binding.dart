import 'package:flutter_atm/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

import '../home/home_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<ProfileController>(ProfileController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
