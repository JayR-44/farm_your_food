import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/local_storage/local_storage.dart';
import 'package:mohammad_wadho_test/global/customs/widgets/dashboard_card.dart';
import 'package:mohammad_wadho_test/global/utils/app_text_styles.dart';
import 'package:mohammad_wadho_test/global/utils/widget_spacing.dart';
import '../../../../generated/assets.dart';
import '../../../../global/customs/custom_app_bar.dart';
import '../../../../global/widgets/loading_overlay.dart';
import '../../../routes/app_routes.dart';
import '../../controllers/dashboard/admin_dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                  height: Get.height,width: double.infinity),
              CustomAppBar(
                  title:LocalStorage.getUserName(),
                onTap: (){
                    controller.logOut();
                },
              ),
              Positioned(
                  top: Get.height * 0.23,
                  left: 20,
                  child:showDetailCard(
                      title: "Create A Store",
                      detail: "Start Selling Natural & Healthy Goods",
                      height: Get.height * 0.23,
                      width:Get.width * 0.9,
                      image: Assets.store,
                      onTap: (){
                        Get.toNamed(Routes.createStore);
                      }
                  ),
              ),

              Positioned(
                top: Get.height * 0.49,
                left: 20,
                child:showDetailCard(
                    title: "Add Products",
                    detail: "Add Products to Your Online Store",
                    height: Get.height * 0.23,
                    width:Get.width * 0.9,
                    image: Assets.vegetables,
                    onTap: (){
                      Get.toNamed(Routes.addProducts);
                    }
                ),
              ),

              Positioned(
                top: Get.height * 0.75,
                left: 20,
                child:showDetailCard(
                    title: "Check Orders",
                    detail: "View Your Received orders and Delivery Goods",
                    height: Get.height * 0.23,
                    width:Get.width * 0.9,
                    image: Assets.orders,
                    onTap: (){
                      Get.toNamed(Routes.checkOrders);
                    }
                ),
              ),

              Obx(() => controller.isLoading.value
                  ? const Center(child: LoadingOverlay())
                  : const SizedBox()),
            ],
          )),
    );
  }
}
