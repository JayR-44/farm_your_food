// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/modules/models/data_model.dart';

import '../../../../../generated/assets.dart';
import '../../../Services/dashboard_services.dart';
import '../../../Services/user_services.dart';
import '../../../local_storage/local_storage.dart';
import '../../../routes/app_routes.dart';

import '../../models/user_model.dart';

class DashboardScreenController extends GetxController {


  RxBool isLoading = false.obs;

  RxList<DataModel> dataList =
      <DataModel>[].obs;




  Future<void> fetchData() async {
    try {
      isLoading.value = true;
     // dataList.value = await DashboardServices.getData();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }



  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void logOut() {
    LocalStorage.removeUserDetails();
    Get.offAllNamed(Routes.login);
  }

}
