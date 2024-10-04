import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/local_storage/local_storage.dart';
import 'package:mohammad_wadho_test/app/modules/controllers/dashboard/user_admin_dashboard_controller.dart';
import 'package:mohammad_wadho_test/global/constants/color_constants.dart';
import 'package:mohammad_wadho_test/global/customs/widgets/dashboard_card.dart';
import 'package:mohammad_wadho_test/global/utils/app_text_styles.dart';
import 'package:mohammad_wadho_test/global/utils/widget_spacing.dart';
import '../../../../generated/assets.dart';
import '../../../../global/customs/custom_app_bar.dart';
import '../../../../global/widgets/loading_overlay.dart';
import '../../../routes/app_routes.dart';
import '../../controllers/dashboard/admin_dashboard_controller.dart';

class UserDashboardScreen extends GetView<UserDashboardScreenController> {
  const UserDashboardScreen({Key? key}) : super(key: key);



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
                      title: "Explore Fresh Goods",
                      detail: "Buy Fruits, Seeds, Vegetables and All natural goods",
                      height: Get.height * 0.23,
                      width:Get.width * 0.9,
                      image: Assets.cart,
                      onTap: (){
                        Get.toNamed(Routes.createStore);
                      }
                  ),
              ),

              Positioned(
                top: Get.height * 0.49,
                left: 25,
                child:Text("Categories",style: AppTextStyles.normal.copyWith(fontSize: 15,color: kSecondaryColor))
              ),

              Positioned(
                top: Get.height * 0.53,
                left: 27,
                child:Row(
                  children: [
                     DashboardCard(
                      title: "Fruits",
                      pngImage: Assets.fruits,
                      onTap: ()=>{Get.toNamed(Routes.showProducts,arguments:["Fruits",Assets.fruits])},
                    ),
                    20.horizontalSpace,
                     DashboardCard(
                      title: "Vegetables",
                      pngImage: Assets.vegetables,
                      onTap: ()=>{Get.toNamed(Routes.showProducts,arguments:["Vegetables",Assets.vegetables])},
                    )
                  ],
                )
              ),

              Positioned(
                  top: Get.height * 0.75,
                  left: 27,
                  child:Row(
                    children: [
                       DashboardCard(
                        title: "Seeds",
                        pngImage: Assets.seed,
                        onTap: ()=>{Get.toNamed(Routes.showProducts,arguments:["Seeds",Assets.seed])},
                      ),
                      20.horizontalSpace,
                       DashboardCard(
                        title: "Wheat",
                        pngImage: Assets.wheat,
                        onTap: ()=>{Get.toNamed(Routes.showProducts,arguments:["Wheat",Assets.wheat])},
                      )
                    ],
                  )
              ),


              Obx(() => controller.isLoading.value
                  ? const Center(child: LoadingOverlay())
                  : const SizedBox()),
            ],
          )),
    );
  }
}
