// ignore_for_file: avoid_print

import 'dart:io';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../generated/assets.dart';
import '../../../../global/constants/pick_image.dart';
import '../../../../global/customs/widgets/animated_dialog_box.dart';
import '../../../Services/auth_services.dart';
import '../../../Services/common_services.dart';
import '../../../routes/app_routes.dart';
import '../../models/user_model.dart';

class RegistrationScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referredByController = TextEditingController();

  RxString confirmPassword = ''.obs;
  RxString photoUrl = ''.obs;
  String accountType = '';
  RxBool obscureText = true.obs;
  RxBool confirmObscureText = true.obs;
  RxBool isLoading = false.obs;
  RxBool validationError = false.obs;

  Rx<File> image = File("").obs;

  TextEditingController nameController = TextEditingController();
  final phoneController = MaskedTextController(mask: '+00 0000 000000');


  signup() async {
    if (formKey.currentState!.validate())  {
      if (passwordController.text != confirmPasswordController.text) {
        confirmPassword.value = "Confirm password did not match";
      } else {
        confirmPassword.value = '';
        try {
          isLoading.value = true;
          if (image.value.toString() != "File: ''") {
            photoUrl.value = await CommonServices.uploadImage(image.value);
          }

          UserModel userModel = UserModel(
            userName: nameController.text,
            email: emailController.text.toLowerCase(),
            phoneNo: phoneController.text,
            accountType: accountType,
            password: passwordController.text,
          );
          await AuthService.registerUser(userModel);
          isLoading.value = false;
          showDialog();
        } catch (e) {
          isLoading.value = false;
          showErrorDialog(e.toString());
        }
      }
    }
  }

  showDialog() {
    var dialogContext = Get.context!;
    animatedDialog(
      dialogContext,
      button1Text: "Done",
      title:"Submitted",
      description:"You Have Successfully created your account. Please login",
      onTapButton1: () {
        Navigator.of(dialogContext).pop();
        Get.offAllNamed(Routes.login);

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




  pickImage() async {
    XFile? pickedFile = await selectImage();
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      photoUrl.value = '';
    }
  }

  @override
  void onInit() {
    accountType = Get.arguments;
    phoneController.updateText('+92');
    super.onInit();
  }


}
