import 'package:flutter/material.dart';
import 'package:flutter_atm/app/common/lifecycle/_index.dart';
import 'package:flutter_atm/app/routes/app_pages.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:get/get.dart';

class OnBoardingController extends BaseController {
  final myPageController = PageController(initialPage: 0);

  final contentData = [].obs;
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContentData();
  }

  void goLoginPage() async {
    await Get.toNamed(Routes.LOGIN);
    currentPage.value = 0;
  }

  void fetchContentData() async {
    var list = [
      {
        "contentTitle": lorem(paragraphs: 1, words: 1),
        "contentDescription": lorem(paragraphs: 1, words: 10),
        "pictureType": "svg",
        "contentImage": "assets/images/onboarding_1.svg",
      },
      {
        "contentTitle": lorem(paragraphs: 1, words: 1),
        "contentDescription": lorem(paragraphs: 1, words: 10),
        "pictureType": "svg",
        "contentImage": "assets/images/onboarding_2.svg",
      },
      {
        "contentTitle": lorem(paragraphs: 1, words: 1),
        "contentDescription": lorem(paragraphs: 1, words: 10),
        "pictureType": "svg",
        "contentImage": "assets/images/onboarding_3.svg",
      },
      {
        "contentTitle": lorem(paragraphs: 1, words: 1),
        "contentDescription": lorem(paragraphs: 1, words: 10),
        "pictureType": "svg",
        "contentImage": "assets/images/onboarding_4.svg",
      },
      {
        "contentTitle": lorem(paragraphs: 1, words: 1),
        "contentDescription": lorem(paragraphs: 1, words: 10),
        "pictureType": "svg",
        "contentImage": "assets/images/onboarding_5.svg",
      },
    ];
    contentData.assignAll(list);
  }
}
