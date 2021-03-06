import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Value;
import 'package:velocity_x/velocity_x.dart';

import '../../common/lifecycle/_index.dart';
import '../../common/resource/_index.dart';
import '../../constants/_common.dart';
import '../../routes/app_pages.dart';

class HomeController extends BaseController with StateMixin<int> {
  final menuList = [].obs;
  final welcomeText = ''.obs;

  @override
  Future<void> onInit() async {
    await _fetchData();
    super.onInit();
  }

  void menuItemClick(int id, String name) {
    switch (id) {
      case MENU_DEPOSIT:
        _showBottomDialog('DEPOSIT', (amount) async {
          await db.deposit(dataUser.value, double.parse(amount));
        });
        break;
      case MENU_WITHDRAW:
        _showBottomDialog('WITHDRAW', (amount) async {
          await db.withdraw(dataUser.value, double.parse(amount));
        });
        break;
      case MENU_TRANSFER:
        Get.toNamed(Routes.TRANSFER, arguments: dataUser.value.username);
        break;
      case MENU_MUTATION:
        Get.toNamed(Routes.MUTATION, arguments: dataUser.value.username);
        break;
      default:
        snackBar(title: '$id', message: 'menu $name belum di mapping');
        break;
    }
  }

  // —————————————————————————————————————————————————————————————————————————
  // Private Func
  // —————————————————————————————————————————————————————————————————————————

  Future <void> _fetchData() async {
    change(null, status: RxStatus.loading());
    try {
      await getCurrentUser();
      await _getUserMenu();
      _checkTimeZone();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(503, status: RxStatus.error(e.toString()));
    }
  }


  Future <void> _getUserMenu() async {
    final listMenu = [
      {'id': MENU_DEPOSIT, 'icon': 'assets/images/menu_home_1.png', 'label': 'DEPOSIT', 'badge': false},
      {'id': MENU_WITHDRAW, 'icon': 'assets/images/menu_home_2.png', 'label': 'WITHDRAW', 'badge': false},
      {'id': MENU_TRANSFER, 'icon': 'assets/images/menu_home_3.png', 'label': 'TRANSFER', 'badge': false},
      {'id': MENU_MUTATION, 'icon': 'assets/images/menu_home_3.png', 'label': 'DAFTAR MUTASI', 'badge': false},
    ];
    menuList.assignAll(listMenu);
  }

  void _checkTimeZone() {
    final now = DateTime.now().toStringEx(format: 'HH');
    final nowToNumber = int.parse(now);
    if (nowToNumber > 0 || nowToNumber < 10)
      welcomeText.value = 'Selamat Pagi';
    else if (nowToNumber >= 11 || nowToNumber < 14)
      welcomeText.value = 'Selamat Siang';
    else if (nowToNumber >= 15 || nowToNumber < 18)
      welcomeText.value = 'Selamat Sore';
    else if (nowToNumber >= 19 || nowToNumber < 24)
      welcomeText.value = 'Selamat Malam';
    else
      welcomeText.value = 'Halo';
  }

  void _showBottomDialog(String title, Function(String) onSubmit) {
    final tfInput = TextEditingController();
    bottomSheetContentDialog(
      title: title,
      childrenWidget: VStack([
        ExTextFieldLabeled(
          tfController: tfInput,
          label: 'Masukkan Jumlah $title',
          hint: 'Rp.1.000.0000',
          keyboardType: TextInputType.number,
          onChanged: (value) => update(),
        ),
        8.heightBox,
        GetBuilder<HomeController>(
          builder: (controller) {
            return tfInput.text.isNotBlank ? rupiahFormat(double.parse(tfInput.text)).text.make() : 0.heightBox;
          },
        ),
        16.heightBox,
        ExButtonOutline(
            width: double.infinity,
            btnText: 'Submit',
            color: colorPrimary,
            onPress: () {
              onSubmit.call(tfInput.text);
              Get.back();
            }),
        50.heightBox,
      ]),
    );
  }
}
