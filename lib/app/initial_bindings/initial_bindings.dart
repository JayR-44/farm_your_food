import 'package:get/get.dart';
import 'package:mohammad_wadho_test/app/modules/controllers/create_store_controller.dart';
import 'package:mohammad_wadho_test/app/modules/controllers/dashboard/user_admin_dashboard_controller.dart';
import 'package:mohammad_wadho_test/app/modules/controllers/show_products_screen_controller.dart';
import 'package:mohammad_wadho_test/app/modules/views/check_orders.dart';
import '../controllers/auth_controller.dart';
import '../modules/controllers/add_products_controller.dart';
import '../modules/controllers/authentication/login_screen_controller.dart';
import '../modules/controllers/authentication/registration_screen_controller.dart';
import '../modules/controllers/check_orders_screen_controller.dart';
import '../modules/controllers/dashboard/admin_dashboard_controller.dart';
import '../modules/controllers/order_screen_controller.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => RegistrationScreenController());
    Get.lazyPut(() => DashboardScreenController());
    Get.lazyPut(() => CreateStoreController());
    Get.lazyPut(() => AddProductsController());
    Get.lazyPut(() => UserDashboardScreenController());
    Get.lazyPut(() => ShowProductsScreenController());
    Get.lazyPut(() => OrderScreenController());
    Get.lazyPut(() => CheckOrderScreenController());

  }
}
