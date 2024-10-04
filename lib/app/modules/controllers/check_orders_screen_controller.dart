import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/local_storage/local_storage.dart';
import 'package:mohammad_wadho_test/app/modules/models/order_model.dart';
import 'package:mohammad_wadho_test/global/constants/color_constants.dart';

import '../../Services/product_services.dart';
import '../models/product_model.dart';

class CheckOrderScreenController extends GetxController{
  RxBool isLoading = false.obs;
  RxBool orderSubmitting = false.obs;
  RxInt totalPrice = 0.obs;

  RxList<OrderModel> myOrdersList = <OrderModel>[].obs;


  getOrders()async{
   // try{
      isLoading.value = true;
      myOrdersList.value = await ProductServices.fetchOrders();
      isLoading.value = false;
    // }catch(e){
    //   isLoading.value = true;
    // }
  }







  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

}