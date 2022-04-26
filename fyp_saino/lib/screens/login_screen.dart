import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyp_saino/components/custom_button.dart';
import 'package:fyp_saino/components/custom_textformfield.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/screens/registration_screen.dart';
import 'package:fyp_saino/utilities/constants.dart';

import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 66, 169, 71),
                  Color(0xFF4CAF50),
                  Color(0xFF66BB6A),
                  Color(0xFF81C784),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    'assets/logos/main.png',
                    width: Get.width * 0.3,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Sign In',
                          style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
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
                        SizedBox(height: 30.0),
                        CustomTextField(
                          decoration: kBoxDecorationStyle,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          controller: pass,
                          obscureText: true,
                          hintText: 'Enter your password',
                        ),
                        SizedBox(height: 90.0),
                        CustomButton(
                            color: Colors.green,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                authController.login(
                                    email: user.text, password: pass.text);
                              }
                            },
                            label: 'Login'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(RegistrationScreen());
                        },
                        child: const Text(' Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkip() {
    return GestureDetector(
        onTap: () {},
        child: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: 'Skip For Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ]),
        ));
  }
}
