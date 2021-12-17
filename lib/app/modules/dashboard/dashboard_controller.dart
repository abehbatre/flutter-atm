import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/modules/profile/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../home/home_view.dart';

class DashboardController extends BaseController {
  final bottomNavigationController = PersistentTabController(initialIndex: 0);

  final pageList = <Widget>[
    HomeView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
