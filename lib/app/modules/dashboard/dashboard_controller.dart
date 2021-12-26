import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../common/lifecycle/_index.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';

class DashboardController extends BaseController {
  final bottomNavigationController = PersistentTabController();

  final pageList = <Widget>[
    const HomeView(),
    const ProfileView(),
  ];
}
