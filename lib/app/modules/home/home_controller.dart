import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:flutter_atm/app/constants/_common.dart';
import 'package:flutter_atm/app/routes/app_pages.dart';
import 'package:get/get.dart' hide Value;
import 'package:velocity_x/velocity_x.dart';

class HomeController extends BaseController with StateMixin<int> {
  final menuList = [].obs;
  final welcomeText = ''.obs;

  @override
  Future<void> onInit() async {
    await _fetchData();
    super.onInit();
  }

  menuItemClick(int id, String name) {
    switch (id) {
      case MENU_DEPOSIT:
        _showBottomDialog('DEPOSIT', (amount) async {
          await db.deposit(dataUser.value, double.parse(amount)).then((value) => onInit()).then((value){
            snackBarSuccess(message: 'Sukses deposit sebesar Rp. $amount');
          });
        });
        break;
      case MENU_WITHDRAW:
        _showBottomDialog('WITHDRAW', (amount) async {
          await db.withdraw(dataUser.value, double.parse(amount)).then((value) => onInit()).then((value){
            snackBarSuccess(message: 'Sukses withdraw sebesar Rp. $amount');
          });
        });
        break;
      case MENU_TRANSFER:
        Get.toNamed(Routes.TRANSFER);
        break;
      case MENU_MUTATION:
        Get.toNamed(Routes.MUTATION);
        break;
      default:
        snackBar(title: "$id", message: "menu $name belum di mapping");
        break;
    }
  }

  // —————————————————————————————————————————————————————————————————————————
  // Private Func
  // —————————————————————————————————————————————————————————————————————————

  _fetchData() async {
    change(null, status: RxStatus.loading());
    try {
      await getCurrentUser();
      await _getUserMenu();
      await _checkTimeZone();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(503, status: RxStatus.error(e.toString()));
    }
  }

  _getUserMenu() async {
    var listMenu = [
      {"id": 101, "icon": "assets/images/menu_home_1.png", "label": "DEPOSIT", "badge": false},
      {"id": 102, "icon": "assets/images/menu_home_2.png", "label": "WITHDRAW", "badge": false},
      {"id": 103, "icon": "assets/images/menu_home_3.png", "label": "TRANSFER", "badge": false},
      {"id": 104, "icon": "assets/images/menu_home_3.png", "label": "DAFTAR MUTASI", "badge": false},
    ];
    menuList.assignAll(listMenu);
  }

  _checkTimeZone() {
    var now = DateTime.now().toStringEx(format: 'HH');
    var nowToNumber = int.parse(now);
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

  _showBottomDialog(title, Function(String) onSubmit) {
    var tfInput = TextEditingController();
    bottomSheetContentDialog(
      title: 'DEPOSIT',
      childrenWidget: VStack([
        ExTextFieldLabeled(
          tfController: tfInput,
          label: 'Masukkan Jumlah ${title}',
          hint: 'Rp.1.000.0000',
          keyboardType: TextInputType.number,
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
