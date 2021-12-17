import 'package:flutter_atm/app/constants/_shared_preference_key.dart';
import 'package:flutter_atm/app/modules/login/login_binding.dart';
import 'package:flutter_atm/app/modules/login/login_view.dart';
import 'package:flutter_atm/app/modules/mutation/mutation_binding.dart';
import 'package:flutter_atm/app/modules/mutation/mutation_view.dart';
import 'package:flutter_atm/app/modules/on_boarding/onboarding_binding.dart';
import 'package:flutter_atm/app/modules/on_boarding/onboarding_view.dart';
import 'package:flutter_atm/app/modules/dashboard/dashboard_binding.dart';
import 'package:flutter_atm/app/modules/dashboard/dashboard_view.dart';
import 'package:flutter_atm/app/modules/transfer/transfer_binding.dart';
import 'package:flutter_atm/app/modules/transfer/transfer_view.dart';
import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';

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
    GetPage(name: _Paths.ROOT, page: () => OnBoardingView(), binding: OnBoardingBinding()),


    GetPage(name: _Paths.ON_BOARDING, page: () => OnBoardingView(), binding: OnBoardingBinding()),
    GetPage(name: _Paths.LOGIN, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(name: _Paths.DASHBOARD, page: () => DashboardView(), binding: DashboardBinding()),
    GetPage(name: _Paths.TRANSFER, page: () => TransferView(), binding: TransferBinding()),
    GetPage(name: _Paths.MUTATION, page: () => MutationView(), binding: MutationBinding()),
  ];
}
