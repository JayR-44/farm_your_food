import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/global/constants/color_constants.dart';

import '../../../generated/assets.dart';

Widget logo() {
  return Align(
    alignment: Alignment.topRight,
    child: Image.asset(
      Assets.appLogo,
      width: Get.width * 0.25,
    ),
  );
}