import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_saino/utilities/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPhoneNumber;
  final customValidator;
  final bool obscureText;
  final Icon icon;
  final Decoration decoration;

  const CustomTextField(
      {Key? key,
      required this.controller,
      this.obscureText = false,
      this.customValidator,
      this.isPhoneNumber = false,
      required this.decoration,
      required this.hintText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: decoration,
      child: TextFormField(
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          controller: controller,
          obscureText: obscureText,
          keyboardType:
              isPhoneNumber ? TextInputType.phone : TextInputType.text,
          inputFormatters: isPhoneNumber
              ? [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                ]
              : null,
          validator: (value) => value!.isEmpty
              ? 'Please fill the field'
              : (customValidator != null ? customValidator(value) : null),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: kHintTextStyle,
              prefixIcon: icon,
              hintText: hintText,
              filled: true)),
    );
  }
}
