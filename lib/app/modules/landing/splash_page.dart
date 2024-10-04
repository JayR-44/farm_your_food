import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mohammad_wadho_test/global/constants/color_constants.dart';
import 'package:mohammad_wadho_test/global/constants/constants.dart';

import '../../../generated/assets.dart';
import '../../local_storage/local_storage.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Future.delayed(const Duration(seconds: 3), () {
        LocalStorage.getIntro() == false
            ? Get.offAndToNamed(Routes.intro)
            : LocalStorage.isUserLoggedIn()
                ? LocalStorage.getAccountType() == "user"
                    ? Get.offAndToNamed(Routes.userDashboard)
                    : Get.offAndToNamed(Routes.dashboard)
                : Get.offAndToNamed(Routes.login);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: Image.asset(Assets.splashScreenBackGround, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
