import 'package:get/get.dart';

import 'mutation_controller.dart';

class MutationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MutationController>(
      () => MutationController(),
    );
  }
}
