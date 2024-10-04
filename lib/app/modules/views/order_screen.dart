import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/modules/controllers/order_screen_controller.dart';
import 'package:mohammad_wadho_test/app/modules/models/product_model.dart';
import 'package:mohammad_wadho_test/global/utils/widget_spacing.dart';
import '../../../../../global/widgets/loading_overlay.dart';
import '../../../../generated/assets.dart';
import '../../../../global/constants/color_constants.dart';
import '../../../../global/customs/custom_button.dart';
import '../../../../global/customs/custom_text_field.dart';
import '../../../../global/customs/widgets/logo.dart';
import '../../../../global/utils/app_text_styles.dart';
import '../../../../global/validations/validation.dart';
import '../../../global/customs/widgets/dashboard_card.dart';
import '../controllers/show_products_screen_controller.dart';

class OrderScreen extends GetView<OrderScreenController> {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(()=> CustomButton(
              height: 50,
              width: double.infinity,
              color: controller.cartsList.isEmpty ? kGreyColor:kSecondaryColor,
              onPressed:controller.cartsList.isEmpty  || controller.isLoading.value ? null: () {
                controller.addOrder();
              },
              title: "Order"),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.1),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text("Carts",
                            style: AppTextStyles.loginFontsStyle
                                .copyWith(color: kSecondaryColor)),
                      ),
                      const Expanded(
                        child:Icon(Icons.shopping_cart_sharp,color: kSecondaryColor,size: 30),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text("Total Price",
                            style: AppTextStyles.loginFontsStyle
                                .copyWith(color: kSecondaryColor,fontSize: 20)),
                      ),
                       Expanded(
                        child:Obx(()=> Text("${controller.totalPrice.value}",
                              style: AppTextStyles.loginFontsStyle
                                  .copyWith(color: kSecondaryColor,fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.03),
                  20.verticalSpace,
                  Obx(
                        () => controller.cartsList.isEmpty
                        ? SizedBox(
                        height: Get.height,
                        child: Center(
                            child: Text("No Carts",
                                style: AppTextStyles.semiBold
                                    .copyWith(color: kSecondaryColor))))
                        : Container(
                      height: Get.height,
                      child: ListView.builder(
                        itemCount: controller.cartsList.length,
                        padding: const EdgeInsets.only(bottom: 200),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ShowProductDetailsCard(
                              productImage: Assets.cart,
                                productDetailsModel:
                                controller.cartsList[index],
                                height: Get.height * 0.17,
                                isOrderScreen:true,
                                onTap:null),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() => controller.isLoading.value
              ? const Center(child: LoadingOverlay())
              : const SizedBox()), // Show the LoadingOverlay if isLoading is true
        ],
      ),
    );
  }

}
