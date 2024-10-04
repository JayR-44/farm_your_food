import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/local_storage/local_storage.dart';
import 'package:mohammad_wadho_test/global/constants/color_constants.dart';

import '../../Services/product_services.dart';
import '../models/product_model.dart';

class OrderScreenController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool orderSubmitting = false.obs;
  RxInt totalPrice = 0.obs;

  RxList<ProductDetailsModel> cartsList = <ProductDetailsModel>[].obs;


  getProducts()async{
    try{
      isLoading.value = true;
      cartsList.value = await ProductServices.fetchUserCarts();
      for(var data in cartsList){
        totalPrice+= int.parse(data.productTotalPrice!);
      }
      isLoading.value = false;
    }catch(e){
      isLoading.value = true;
    }
  }



  addOrder() async{
    try{
      isLoading.value = true;
      await ProductServices.addOrder(cartsList,totalPrice.value);

      isLoading.value = false;
      Get.snackbar(
        "Message",
        "Order add successfully",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        backgroundColor:kBlueColor,
        colorText: Colors.white,
      );
      totalPrice.value = 0;
      cartsList.clear();
    }catch(e){
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        backgroundColor:kRedColor,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }




  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

}
