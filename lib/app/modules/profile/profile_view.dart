import 'package:ex_reusable/ex_reusable.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_data/mock_data.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/resource/_index.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: controller.obx(
        (state) => buildUI200(),
        onLoading: const ExUiLoading(),
        onError: (e) => ExUiErrorOrEmpty(
          message: 'Gagal memuat konten\n ${e.toString()}',
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
          buildMenuButton(title: 'Pusat Bantuan', onClick: () => controller.test()),
          buildMenuButton(title: 'RESET DB', textColor: Vx.red500, onClick: () => controller.resetDB()),
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
          SizedBox(
            width: 120,
            child: mockUUID().text.color(colorBlack).size(18).overflow(TextOverflow.ellipsis).semiBold.make(),
          ),
        ]),
        const Spacer(),
        const ExButtonDefault(
          btnText: 'Salin Kode',
          bgColor: paleGrey,
          textColor: colorBlack,
        ),
        8.widthBox,
        const ExButtonDefault(btnText: 'Info'),
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
            url: faker.image.image(width: 1200, height: 900, keywords: ['people', 'nature'], random: true),
            userFullName: controller.dataUser.value.username,
            height: 68,
            borderColor: colorWhite,
            borderWidth: 3,
            width: 68,
          ),
          16.widthBox,
          VStack([
            Obx(() => controller.dataUser.value.username.text.white.uppercase.size(18).bold.make()),
            4.heightBox,
            faker.job.title().text.white.uppercase.make(),
          ]).expand(),
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
          s.text.color(colorGrey).size(12).make().pOnly(left: 24, right: 24, top: 16, bottom: 8),
          const Divider(),
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
            title.text.color(textColor).size(14).make().pOnly(left: 16, top: 10, bottom: 10),
            8.widthBox,
            if (showWarning) Icon(Icons.error, color: Colors.red[800]) else 0.heightBox,
            const Spacer(),
            const Icon(Icons.chevron_right_outlined, color: colorGrey).pOnly(right: 24),
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
            title.text.color(textColor).size(14).make().pOnly(left: 16, top: 10, bottom: 10),
            8.widthBox,
            if (showWarning) Icon(Icons.error, color: Colors.red[800]) else 0.heightBox,
            const Spacer(),
            count.text.color(colorPrimary).size(14).make().pOnly(right: 24),
          ],
        ),
      ),
    );
  }
}
