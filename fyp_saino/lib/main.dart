import 'package:flutter/material.dart';
import 'package:fyp_saino/controller/login_controller.dart';
import 'package:fyp_saino/controller/product_controller.dart';

import 'package:fyp_saino/screens/categories/dairy.dart';
import 'package:fyp_saino/screens/categories/fruits.dart';
import 'package:fyp_saino/screens/categories/grains.dart';
import 'package:fyp_saino/screens/categories/livestocks.dart';
import 'package:fyp_saino/screens/categories/vegetables.dart';
import 'package:fyp_saino/screens/details_screen.dart';
import 'package:fyp_saino/screens/home_screen.dart';

import 'package:fyp_saino/screens/login_screen.dart';

import 'package:fyp_saino/screens/registration_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProductContoller()),
      ChangeNotifierProvider(create: (context) => LoginController())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saino',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        "/home": (BuildContext context) => const HomeScreen(),
        "/login": (BuildContext context) => const LoginScreen(),
        "/register": (BuildContext context) => const RegistrationScreen(),
        "/vegetables": (BuildContext context) => Vegetables(),
        "/fruits": (BuildContext context) => Fruits(),
        "/grains": (BuildContext context) => Grains(),
        "/dairy": (BuildContext context) => Dairy(),
        "/livestocks": (BuildContext context) => LiveStocks(),
        // "/logout":(BuildContext context) => LogOut(),
      },
    );
  }
}
