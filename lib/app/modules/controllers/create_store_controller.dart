// ignore_for_file: avoid_print

import 'dart:io';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohammad_wadho_test/app/Services/store_services.dart';
import 'package:mohammad_wadho_test/app/local_storage/local_storage.dart';
import '../../../../generated/assets.dart';
import '../../../../global/constants/pick_image.dart';
import '../../../../global/customs/widgets/animated_dialog_box.dart';

import '../../routes/app_routes.dart';

class CreateStoreController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController storeName = TextEditingController();
  TextEditingController storeType = TextEditingController();
  TextEditingController description = TextEditingController();



  RxBool isLoading = false.obs;


  Rx<File> image = File("").obs;


  final phoneController = MaskedTextController(mask: '+00 0000 000000');


  submit() async {
    if (formKey.currentState!.validate())  {

      try {
          isLoading.value = true;
          await StoreServices.createStore({
            'storeName':storeName.text,
            'storeType':storeType.text,
            'description':description.text,
            'farmerId':LocalStorage.getUserId(),
          });
          isLoading.value = false;
          showDialog();
        } catch (e) {
          isLoading.value = false;
          showErrorDialog(e.toString());
        }
    }
  }

  showDialog() {
    var dialogContext = Get.context!;
    animatedDialog(
      dialogContext,
      button1Text: "Done",
      title:"Submitted",
      description:"You Have Successfully created your store",
      onTapButton1: () {

        storeName.clear();
        storeType.clear();
        description.clear();

        Navigator.of(dialogContext).pop();

        },
      image: Assets.circle,
      icon: Assets.verify,
      barrierDismissible: false,
    );
  }



  showErrorDialog(message) {
    var dialogContext = Get.context!;
    animatedDialog(
      dialogContext,
      button1Text: "Done",
      title: "Oops!",
      description: "\n $message",
      onTapButton1: () => Navigator.of(dialogContext).pop(),
      image: Assets.circle,
      icon: Assets.error,
      barrierDismissible: true,
    );
  }




}
