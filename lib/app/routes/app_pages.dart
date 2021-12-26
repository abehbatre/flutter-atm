import 'package:get/get.dart';

import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/mutation/mutation_binding.dart';
import '../modules/mutation/mutation_view.dart';
import '../modules/on_boarding/onboarding_binding.dart';
import '../modules/on_boarding/onboarding_view.dart';
import '../modules/transfer/transfer_binding.dart';
import '../modules/transfer/transfer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = _Paths.ROOT;

  static final routes = [
    // STARTER
    // GetPage(
    //   name: _Paths.ROOT,
    //   page: () => pref.read(PREF_IS_LOGIN) == null ? OnBoardingView() : DashboardView(),
    //   binding: pref.read(PREF_IS_LOGIN) == null ? OnBoardingBinding() : DashboardBinding(),
    // ),
    GetPage(
        name: _Paths.ROOT,
        page: () => OnBoardingView(),
        binding: OnBoardingBinding()),

    GetPage(
        name: _Paths.ON_BOARDING,
        page: () => OnBoardingView(),
        binding: OnBoardingBinding()),
    GetPage(
        name: _Paths.LOGIN, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(name: _Paths.HOME, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => const DashboardView(),
        binding: DashboardBinding()),
    GetPage(
        name: _Paths.TRANSFER,
        page: () => TransferView(),
        binding: TransferBinding()),
    GetPage(
        name: _Paths.MUTATION,
        page: () => MutationView(),
        binding: MutationBinding()),

  ];
}
