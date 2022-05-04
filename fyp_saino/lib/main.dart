import 'package:flutter/material.dart';
import 'package:fyp_saino/admin/admin_home.dart';
import 'package:fyp_saino/admin/products_screen.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/controller/cart_controller.dart';
import 'package:fyp_saino/controller/categories_controller.dart';
import 'package:fyp_saino/controller/products_controller.dart';
import 'package:fyp_saino/screens/home_screen.dart';
import 'package:fyp_saino/screens/login_screen.dart';
import 'package:fyp_saino/screens/my_orders.dart';
import 'package:fyp_saino/screens/registration_screen.dart';
import 'package:fyp_saino/screens/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:khalti/khalti.dart';

import 'controller/order_controller.dart';
import 'utilities/auth_checker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(OrderController());
  Get.put(CategoriesController());
  await Khalti.init(
    publicKey: 'test_public_key_ed5025c901a34386b78c72720f86aa5e',
    enabledDebugging: true,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // transition slow
    transitionDuration: Duration(milliseconds: 350),
    // default transition
    defaultTransition: Transition.rightToLeft,
    initialRoute: '/',
    getPages: [
      GetPage(
        name: '/',
        page: () => AuthChecker(),
      ),
      GetPage(
        name: '/splash',
        page: () => SplashScreen(),
      ),
      GetPage(
        name: '/login',
        page: () => LoginScreen(),
      ),
      GetPage(
        name: '/signup',
        page: () => RegistrationScreen(),
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
      ),
      GetPage(
        name: '/admin',
        page: () => AdminHome(),
      ),
      GetPage(
        name: '/my-orders',
        page: () => MyOrders(),
      ),
      GetPage(
        name: '/product-screen',
        page: () => ProductScreen(),
      ),
    ],
  ));
}
