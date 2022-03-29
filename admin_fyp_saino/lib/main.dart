import 'package:admin_fyp_saino/screens/categories.dart';
import 'package:admin_fyp_saino/screens/home_screen.dart';
import 'package:admin_fyp_saino/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:admin_fyp_saino/utilites.dart/constants.dart' as constants;

main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color mainColor = constants.mainColor;
    Color secColor = constants.secTextColor;
    Color textColor = constants.textColor;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Drawer App',
        theme: ThemeData(
            primaryColor: secColor,
            splashColor: mainColor,
            textTheme: TextTheme(
                subtitle1: TextStyle(
                  color: textColor,
                ),
                subtitle2: TextStyle(color: secColor))),
        home:const  LoginScreen(),
        routes: {
          "/home": (BuildContext context) => const HomeScreen(),
          "/logout": (BuildContext context) => const LoginScreen(),
          "/category": (BuildContext context) => const Category(),
        });
  }
}
