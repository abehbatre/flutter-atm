import 'package:ex_reusable/ex_reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/resource/_index.dart';
import '../../models/_key_val.dart';
import 'base_controller.dart';

///   created               : Aditya Pratama
///   originalFilename      : common_widgets
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   modifier              : access only when controller inheritance [BaseController]

enum BSHeaderType { dash, close }

enum BSContentType { regular, radio }

class CommonWidgets {
  // —————————————————————————————————————————————————————————————————————————
  // DIALOG —————————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  void alertDialogSuccess({
    String title = 'Sukses',
    required String message,
    IconData icon = Icons.check_circle,
    bool? withIcon = true,
    double iconSize = 68,
    bool isDismissible = false,
    String btnYesText = 'Selesai',
    double? manualHeightAdditional = 0,
    VoidCallback? onYes,
  }) {
    Get.defaultDialog(
      radius: 10,
      title: '',
      barrierDismissible: isDismissible,
      content: SizedBox(
        width: 290,
        height: 150 + iconSize + manualHeightAdditional!,
        child: VStack(
          <Widget>[
            if (withIcon == true) Icon(icon, color: colorPrimary, size: iconSize).centered() else 0.heightBox,
            title.text.bold.size(20).makeCentered().p8(),
            message.text.size(14).color(battleshipGrey).makeCentered().p8(),
            const HeightBox(10),
            HStack(
              <Widget>[
                Expanded(
                  child: ExButtonDefault(
                    btnText: btnYesText,
                    height: 48,
                    // radius: 28,
                    bgColor: colorPrimary,
                    onPress: onYes ?? () => Get.back(),
                  ),
                ),
              ],
            ).p8(),
          ],
        ).scrollVertical(),
      ),
    );
  }

  void alertDialogError({
    required String title,
    required String message,
    IconData icon = Icons.error_outline_outlined,
    double iconSize = 68,
    bool isDismissible = false,
    String btnYesText = 'Selesai',
    VoidCallback? onYes,
  }) {
    Get.defaultDialog(
      radius: 10,
      title: '',
      content: SizedBox(
        width: 290,
        height: 160 + iconSize,
        child: VStack(
          <Widget>[
            Icon(icon, color: Colors.red, size: iconSize).centered(),
            title.text.bold.size(20).align(TextAlign.center).makeCentered().p8(),
            message.text.size(14).color(battleshipGrey).align(TextAlign.center).makeCentered().p8(),
            const HeightBox(10),
            HStack(
              <Widget>[
                Expanded(
                  child: ExButtonDefault(
                    btnText: btnYesText,
                    height: 48,
                    radius: 28,
                    bgColor: Colors.red,
                    onPress: onYes ?? () => Get.back(),
                  ),
                ),
              ],
            ).p8(),
          ],
        ).scrollVertical(),
      ),
    );
  }

  void alertDialogConfirmation({
    required String title,
    required String message,
    String image = '',
    String btnNoText = 'Batal',
    String btnYesText = 'Ya',
    TextAlign textAlign = TextAlign.left,
    Color btnYesColor = colorPrimary,
    Color btnNoColor = colorPrimary,
    VoidCallback? onYesCallback,
    VoidCallback? onNoCallback,
  }) {
    // logW(message.length);
    Get.defaultDialog(
      radius: 8,
      title: '',
      content: SizedBox(
        width: 290,
        height: 100 + (title == '' ? 0 : 35) + (image == '' ? 0 : 118) + (message == '' ? 0 : 30) + (message.length >= 120 ? 50 : 0),
        child: VStack(
          <Widget>[
            if (image != '') SvgPicture.asset('assets/images/$image', width: 110, height: 110).p(8).centered() else 0.widthBox,
            if (title != '') title.text.bold.size(20).center.make().p8() else 0.widthBox,
            if (message != '') message.text.size(14).color(battleshipGrey).align(textAlign).make().p8() else 0.widthBox,
            const HeightBox(10),
            HStack(
              <Widget>[
                Expanded(
                    child: ExButtonOutline(
                  color: btnNoColor,
                  radius: 8,
                  btnText: btnNoText,
                  onPress: onNoCallback ?? () => Get.back(),
                )),
                12.widthBox,
                Expanded(
                  child: ExButtonDefault(
                    btnText: btnYesText,
                    bgColor: btnYesColor,
                    radius: 8,
                    onPress: onYesCallback ?? () => Get.back(),
                  ),
                ),
              ],
            ).p8(),
          ],
        ).scrollVertical(),
      ),
    );
  }

  void alertCustom({
    required String title,
    required List<KeyVal> listKV,
    required Function(dynamic, dynamic) callback,
    dynamic value,
  }) {
    Get.defaultDialog(
        title: '',
        titleStyle: const TextStyle(fontSize: 1),
        radius: 4,
        content: SizedBox(
          height: 400,
          width: 290,
          child: VStack(<Widget>[
            HStack(
              <Widget>[
                title.text.bold.make(),
                const Spacer(),
                const Icon(Icons.close, color: colorBlack),
              ],
            ),
            const Divider(),
            Expanded(
                child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount: listKV.length,
              itemBuilder: (BuildContext context, int index) {
                return ExRadioButton(
                    title: listKV[index].val,
                    data: listKV[index].key,
                    isBadge: listKV[index].badge ?? false,
                    value: value,
                    onPress: (e) {
                      Get.back();
                      callback(listKV[index].key, listKV[index].val);
                    });
              },
            )),
          ]),
        ));
  }

  // —————————————————————————————————————————————————————————————————————————
  // SNACK BAR —————————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  void snackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    int durationInSecond = 2,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      barBlur: 8.0,
      snackPosition: position,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
      duration: Duration(seconds: durationInSecond),
    );
  }

  void snackBarError({
    String title = 'Gagal',
    String message = '',
    SnackPosition position = SnackPosition.TOP,
    int durationInSecond = 2,
  }) {
    Get.snackbar(title, message,
        backgroundColor: const Color(0x73ff0000),
        barBlur: 8.0,
        colorText: colorWhite,
        snackPosition: position,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
        duration: Duration(seconds: durationInSecond),
        icon: const Icon(Icons.error, color: Colors.white));
  }

  void snackBarSuccess({
    String title = 'Sukses',
    String message = '',
    SnackPosition position = SnackPosition.TOP,
    int durationInSecond = 2,
  }) {
    Get.snackbar(title, message,
        backgroundColor: const Color(0x8A2E7D32),
        barBlur: 8.0,
        colorText: colorWhite,
        snackPosition: position,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
        duration: Duration(seconds: durationInSecond),
        icon: const Icon(Icons.check_circle, color: Colors.white));
  }

  // —————————————————————————————————————————————————————————————————————————
  // LOADING DIALOG  —————————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  void loadingDialog() {
    Get.dialog(
        Material(
          color: Colors.black26,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(48.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: VStack([
                const CupertinoActivityIndicator().pOnly(left: 32),
                24.heightBox,
                ExButtonOutline(btnText: 'Cancel', color: colorPrimary, onPress: () => Get.back()),
              ]),
            ),
          ),
        ),
        barrierDismissible: false,
        name: 'Loading Dialog');
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  // —————————————————————————————————————————————————————————————————————————
  // BOTTOM SHEET DIALOG  ————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  void bottomSheetContentDialog({
    required String title,
    String? desc = '',
    required Widget childrenWidget,
    IconData? endIcon,
    BSHeaderType headerType = BSHeaderType.dash,
  }) {
    Get.bottomSheet(
      Container(
        decoration: boxBottomSheetRadiusDecoration(),
        child: VStack(
          [
            if (headerType == BSHeaderType.dash)
              VStack([
                const ExDashLine(),
                HStack([
                  title.text.bold.size(18).make().pOnly(top: 24, bottom: desc!.isNotEmpty ? 0 : 24),
                  const Spacer(),
                  Icon(endIcon),
                ]),
                if (desc.isNotEmpty) desc.text.size(13).color(colorGrey).make().pOnly(top: 8, bottom: 24),
              ])
            else
              HStack([
                title.text.color(colorBlack).size(18).bold.make(),
                IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close_rounded, size: 30, color: greyThree)),
              ], alignment: MainAxisAlignment.spaceBetween)
                  .w(double.infinity - 48),
            Wrap(children: [childrenWidget]),
          ],
        ).p24(),
      ),
      elevation: 10,
      isScrollControlled: true,
    );
  }

  void bottomSheetListDialog({
    required List<KeyVal> listKV,
    required String title,
    dynamic value,
    bool? showTotalData = false,
    bool isFullScreen = false,
    BSHeaderType headerType = BSHeaderType.dash,
    BSContentType contentType = BSContentType.regular,
    required Function(dynamic, dynamic) callback,
    String? emptyMessage = '',
    Function? emptyCallback,
    double? radius = 16,
  }) {
    final int totalData = listKV.length;
    Get.bottomSheet(
      DraggableScrollableSheet(
          builder: (_, ScrollController controller) => Container(
                decoration: boxBottomSheetRadiusDecoration(),
                child: VStack(
                  [
                    if (headerType == BSHeaderType.close)
                      HStack([
                        title.text.color(colorBlack).size(18).bold.make(),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.close_rounded, size: 30, color: greyThree)),
                      ], alignment: MainAxisAlignment.spaceBetween)
                          .w(double.infinity)
                          .pSymmetric(v: 24, h: 24)
                    else
                      VStack([
                        const ExDashLine().p24(),
                        const HeightBox(8),
                        if (showTotalData == true)
                          '$title ($totalData)'.text.size(18).semiBold.black.make().paddingOnly(left: 24, right: 24)
                        else
                          title.text.size(18).semiBold.black.make().paddingOnly(left: 24, right: 24),
                        12.heightBox,
                      ]),
                    Expanded(
                      child: listKV.isNotEmpty
                          ? ListView.separated(
                              controller: controller,
                              separatorBuilder: (BuildContext context, int index) => const Divider(),
                              itemCount: listKV.length,
                              itemBuilder: (BuildContext context, int index) {
                                return contentType == BSContentType.regular
                                    ? listKV[index].val.text.black.make().pOnly(left: 24, right: 24, top: 8, bottom: 8).onInkTap(() {
                                        Get.back();
                                        callback(listKV[index].key, listKV[index].val);
                                      })
                                    : ExRadioButton(
                                        title: listKV[index].val,
                                        data: listKV[index].key,
                                        isBadge: listKV[index].badge ?? false,
                                        value: value,
                                        onPress: (e) {
                                          Get.back();
                                          callback(listKV[index].key, listKV[index].val);
                                        });
                              },
                            )
                          : VStack([
                              ExUiErrorOrEmpty(
                                message: emptyMessage ?? '',
                                callback: () => emptyCallback,
                                svgAssets: 'assets/images/ui_no_message.svg',
                              ).centered(),
                            ]).scrollVertical(),
                    ),
                  ],
                ),
              )),
      isScrollControlled: true,
      isDismissible: true,
    );
  }

  // —————————————————————————————————————————————————————————————————————————
  // CONTAINER BORDER  ———————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  BoxDecoration boxBottomSheetRadiusDecoration({double radius = 16}) {
    return BoxDecoration(
      color: colorWhite,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }

  BoxDecoration commonBoxDecoration({
    Color borderColor = whiteGrey,
    Color? fillColor = Colors.transparent,
    double radius = 8,
  }) {
    return BoxDecoration(
      color: fillColor,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(radius),
    );
  }

  BoxDecoration commonBoxShadow({
    Color borderColor = whiteGrey,
    Color fillColor = Colors.transparent,
    double radius = 8,
    double blurRadius = 5.0,
    double offsetDx = 0.0,
    double offsetDy = 0.55,
  }) {
    return BoxDecoration(
      color: fillColor,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: colorBlack05,
          blurRadius: blurRadius,
          spreadRadius: 10,
          offset: Offset(offsetDx, offsetDy),
        ),
      ],
    );
  }

  BoxDecoration boxCircle({
    Color color = Colors.black38,
  }) {
    return BoxDecoration(color: color, shape: BoxShape.circle);
  }
}
