import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyp_saino/components/custom_button.dart';
import 'package:fyp_saino/components/custom_textformfield.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/utilities/constants.dart';

import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController number = TextEditingController();
  String? grade;
  String? gradeError;
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: Get.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromARGB(255, 66, 169, 71),
                  Color(0xFF4CAF50),
                  Color(0xFF66BB6A),
                  Color(0xFF81C784),
                ])),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Register ',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(Icons.portrait, color: Colors.white),
                          controller: name,
                          obscureText: false,
                          hintText: 'Enter your name',
                        ),
                        SizedBox(height: 20.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(Icons.home_work_outlined,
                              color: Colors.white),
                          controller: address,
                          obscureText: false,
                          hintText: 'Enter your address',
                        ),
                        SizedBox(height: 20.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(Icons.phone, color: Colors.white),
                          isPhoneNumber: true,
                          controller: number,
                          obscureText: false,
                          hintText: 'Enter your phone number',
                          customValidator: (value) {
                            //validate 10 digits
                            if (value.length != 10) {
                              return 'Please enter a valid phone number';
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(Icons.email, color: Colors.white),
                          customValidator: (value) {
                            //email validation
                            final bool isValid = EmailValidator.validate(value);
                            if (!isValid) {
                              return 'Please enter a valid email';
                            }
                          },
                          controller: user,
                          obscureText: false,
                          hintText: 'Enter your email',
                        ),
                        SizedBox(height: 20.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          customValidator: (value) {
                            //password validation
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                          },
                          controller: pass,
                          obscureText: true,
                          hintText: 'Enter your password',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        CustomButton(
                            color: Colors.green,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                authController.signUp(
                                    email: user.text,
                                    name: name.text,
                                    phone: number.text,
                                    address: address.text,
                                    password: pass.text);
                              }
                            },
                            label: "Sign Up"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an Account?",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text('Log In',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueAccent,
                                  fontSize: 16)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
