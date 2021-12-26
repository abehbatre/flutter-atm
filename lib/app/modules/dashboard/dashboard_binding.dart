import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../profile/profile_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
