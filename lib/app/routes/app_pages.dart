import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:mohammad_wadho_test/app/modules/landing/account_type_screen.dart';
import 'package:mohammad_wadho_test/app/modules/views/check_orders.dart';
import 'package:mohammad_wadho_test/app/modules/views/dashboard/user_dashboard.dart';
import 'package:mohammad_wadho_test/app/modules/views/order_screen.dart';
import 'package:mohammad_wadho_test/app/modules/views/show_products.dart';
import '../../global/constants/constants.dart';
import '../initial_bindings/initial_bindings.dart';
import '../modules/landing/intro_screen.dart';
import '../modules/landing/splash_page.dart';
import '../modules/views/add_product.dart';
import '../modules/views/authentications/login_screen.dart';
import '../modules/views/authentications/registration_screen.dart';
import '../modules/views/create_store.dart';
import '../modules/views/dashboard/dashboard.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static List<GetPage> getPages() {
    return [
      GetPage(
          name: Routes.splash,
          page: () => const SplashScreen(),
          transition: routeTransition),

      GetPage(
          name: Routes.intro,
          page: () => const IntroScreen(),
          transition: routeTransition),

      GetPage(
          name: Routes.accountType,
          page: () => const AccountType(),
          transition: routeTransition),

      GetPage(
          name: Routes.login,
          page: () => const LoginScreen(),
          binding: InitialBindings(),
          transition: routeTransition),
      GetPage(
          name: Routes.signup,
          page: () => const RegistrationScreen(),
          binding: InitialBindings(),
          transition: routeTransition),

      GetPage(
          name: Routes.dashboard,
          page: () => const DashboardScreen(),
          binding: InitialBindings(),
          transition: routeTransition),


      GetPage(
          name: Routes.createStore,
          page: () => const CreateStore(),
          binding: InitialBindings(),
          transition: routeTransition),

      GetPage(
          name: Routes.addProducts,
          page: () => const AddProducts(),
          binding: InitialBindings(),
          transition: routeTransition),

  GetPage(
          name: Routes.userDashboard,
          page: () => const UserDashboardScreen(),
          binding: InitialBindings(),
          transition: routeTransition),

  GetPage(
          name: Routes.showProducts,
          page: () => const ShowProductsScreen(),
          binding: InitialBindings(),
          transition: routeTransition),

      GetPage(
          name: Routes.order,
          page: () => const OrderScreen(),
          binding: InitialBindings(),
          transition: routeTransition),

      GetPage(
          name: Routes.checkOrders,
          page: () => const CheckOrdersScreen(),
          binding: InitialBindings(),
          transition: routeTransition),

    ];
  }
}
