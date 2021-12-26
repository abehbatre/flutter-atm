import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/resource/_index.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(
        init: DashboardController(),
        initState: (_) {},
        builder: (_) {
          return PersistentTabView(
            context,
            controller: _.bottomNavigationController,
            screens: _.pageList,
            items: _navBarsItems(),
            resizeToAvoidBottomInset: true,
            // onItemSelected:(value) => controller.onNavChange(value) ,
            popAllScreensOnTapOfSelectedTab: false,
            popActionScreens: PopActionScreensType.once,
            itemAnimationProperties: ItemAnimationProperties(duration: 300.milliseconds, curve: Curves.easeIn),
            screenTransitionAnimation: ScreenTransitionAnimation(curve: Curves.easeIn, duration: 300.milliseconds),
            navBarStyle: NavBarStyle.style12,
          );
        },
      ),
    );
  }

  // —————————————————————————————————————————————————————————————————————————
  // SPLIT COMPONENT —————————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(ExIcons.fi_rr_home),
        title: 'Beranda',
        iconSize: 20,
        activeColorPrimary: colorPrimary,
        inactiveColorPrimary: battleshipGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(ExIcons.fi_rr_user),
        title: 'Profile',
        iconSize: 20,
        activeColorPrimary: colorPrimary,
        inactiveColorPrimary: battleshipGrey,
      ),
    ];
  }
}
