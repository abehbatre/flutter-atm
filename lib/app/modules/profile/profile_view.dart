import 'package:ex_reusable/ex_reusable.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_atm/app/common/resource/_index.dart';
import 'package:mock_data/mock_data.dart';
import 'package:velocity_x/velocity_x.dart';

import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: controller.obx(
        (state) => buildUI200(),
        onLoading: ExUiLoading(),
        onError: (e) => ExUiErrorOrEmpty(
          message: "Gagal memuat konten\n ${e.toString()}",
          showBtnRetry: true,
          callback: () => controller.onInit(),
        ),
      ),
    );
  }

  VStack buildUI200() {
    return VStack([
      buildHeader(),
      buildUniqueCode(),
      // buildMenuButton(title: 'Teman Saya'),
      24.heightBox,
      Expanded(
        child: VStack([
          buildSection('Info & Bantuan'),
          buildMenuButton(title: 'Tentang Aplikasi', textColor: greenOnlineColor),
          buildMenuButton(title: 'Pusat Bantuan'),
          buildMenuButton(title: 'Dev Tool', textColor: greenOnlineColor),
          24.heightBox,
          buildMenuButton(title: 'Keluar', textColor: colorPrimary, onClick: () => controller.logout()),
          40.heightBox,
        ]).scrollVertical(),
      )
    ]);
  }

  Container buildUniqueCode() {
    return Container(
      decoration: controller.commonBoxDecoration(fillColor: colorWhite, borderColor: Colors.transparent),
      child: HStack([
        VStack([
          'Kode Unique'.text.color(colorGrey).size(15).make(),
          4.heightBox,
          Container(
            width: 120,
            child: '${mockUUID()}'.text.color(colorBlack).size(18).overflow(TextOverflow.ellipsis).semiBold.make(),
          ),
        ]),
        Spacer(),
        ExButtonDefault(
          btnText: 'Salin Kode',
          bgColor: paleGrey,
          textColor: colorBlack,
        ),
        8.widthBox,
        ExButtonDefault(btnText: 'Info'),
      ]).p24(),
    );
  }

  Widget buildHeader() {
    return Container(
      height: 155,
      width: double.infinity,
      decoration: controller.commonBoxDecoration(fillColor: colorPrimary, borderColor: colorPrimary, radius: 0),
      child: VStack([
        24.heightBox,
        HStack([
          ExAvatarView(
            url: '${faker.image.image(width: 1200, height: 900, keywords: ['people', 'nature'], random: true)}',
            userFullName: '${controller.dataUser.value.username}',
            height: 68,
            borderColor: colorWhite,
            borderWidth: 3,
            width: 68,
          ),

          16.widthBox,
          VStack([
            Obx(() => '${controller.dataUser.value.username}'.text.white.uppercase.size(18).bold.make()),
            4.heightBox,
            '${faker.job.title()}'.text.white.uppercase.make(),
          ]),
        ]),
      ]).p24(),
    );
  }

  Widget buildSection(String s) {
    return Container(
      color: colorWhite,
      width: double.infinity,
      child: VStack(
        [
          '$s'.text.color(colorGrey).size(12).make().pOnly(left: 24, right: 24, top: 16, bottom: 8),
          Divider(),
        ],
      ),
    );
  }

  Widget buildMenuButton({
    required String title,
    Color textColor = colorBlack,
    bool showWarning = false,
    VoidCallback? onClick,
  }) {
    return Container(
      color: colorWhite,
      child: TextButton(
        onPressed: onClick,
        child: HStack(
          [
            '$title'.text.color(textColor).size(14).make().pOnly(left: 16, top: 10, bottom: 10),
            8.widthBox,
            showWarning ? Icon(Icons.error, color: Colors.red[800]) : 0.heightBox,
            Spacer(),
            Icon(Icons.chevron_right_outlined, color: colorGrey).pOnly(right: 24),
          ],
        ),
      ),
    );
  }

  Widget buildMenuLabeled({
    required String title,
    required String count,
    Color textColor = colorBlack,
    bool showWarning = false,
    VoidCallback? onClick,
  }) {
    return Container(
      color: colorWhite,
      child: TextButton(
        onPressed: onClick,
        child: HStack(
          [
            '$title'.text.color(textColor).size(14).make().pOnly(left: 16, top: 10, bottom: 10),
            8.widthBox,
            showWarning ? Icon(Icons.error, color: Colors.red[800]) : 0.heightBox,
            Spacer(),
            '$count'.text.color(colorPrimary).size(14).make().pOnly(right: 24),
          ],
        ),
      ),
    );
  }
}
