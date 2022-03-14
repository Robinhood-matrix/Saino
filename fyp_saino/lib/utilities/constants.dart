import 'package:flutter/material.dart';

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
  boxShadow: [
    const BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);