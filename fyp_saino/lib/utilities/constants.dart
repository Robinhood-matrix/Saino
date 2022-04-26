import 'package:flutter/material.dart';

const kPrimaryColor = Color(0XFF00E400);
const kSecondaryColor = Color(0XFF009800);

const kHintTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white70,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF4CAF50),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0,
      offset: Offset(0, 4),
    ),
  ],
);

class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const gray = Color(0xFFF6F6F6);
  static const black = Color(0xFF1F1F1F);
  static const gray_light=Color(0xFFE5E5E5);
  static const light_yellow = Color(0xFFFFD980);
  static const dark_yellow = Color(0xFFFCA34B);


  static const light_pink=Color(0xFFFADCDF);
  static const dark_pink=Color(0xFFEEB5BB);

  static const light_y=Color(0xFFFFF9CF);
  static const dark_y=Color(0xFFF5DC9E);



  static const light_blue=Color(0xFFDDDDFC);
  static const dark_blue=Color(0xFFAEAFE5);


  static const light_green=Color(0xFFCFFFC8);
  static const dark_green=Color(0xFFA8E4A6);


  static const light_p=Color(0xFFFFEAFE);
  static const dark_p=Color(0xFFE7A2DC);

}
