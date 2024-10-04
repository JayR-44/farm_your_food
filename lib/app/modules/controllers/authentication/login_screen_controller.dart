// ignore_for_file: unused_local_variable


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../generated/assets.dart';
import '../../../../../global/customs/widgets/animated_dialog_box.dart';
import '../../../Services/auth_services.dart';
import '../../../local_storage/local_storage.dart';
import '../../../routes/app_routes.dart';
import '../../models/user_model.dart';

class LoginScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isSelected = false.obs;
  RxBool obscureText = true.obs;

  login() async {
    FocusScope.of(Get.context!).unfocus();
    if (formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
        email: emailController.text,
        password: passwordController.text,
      );
      try {
        isLoading.value = true;
        UserModel model = await AuthService.loginUser(userModel);
        if (model.userId != null && model.userId != "") {
          print("model : ${model.accountType}");

          LocalStorage.saveUserInfo(model);
          LocalStorage.setIsUserLoggedIn(isSelected.value);
          if(model.accountType.toString() == "user"){
            Get.offAllNamed(Routes.userDashboard);

          }else{
            Get.offAllNamed(Routes.dashboard);
          }
          // Navigate to the home screen or any other d
          // esired screen
        }
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        showErrorDialog(e);
      }
    }
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

  rememberMe() {
    isSelected.value = !isSelected.value;
  }
}
