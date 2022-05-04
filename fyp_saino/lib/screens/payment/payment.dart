import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_saino/components/custom_textformfield.dart';
import 'package:fyp_saino/controller/cart_controller.dart';
import 'package:fyp_saino/utilities/constants.dart';
import 'package:get/get.dart';
import 'package:khalti/khalti.dart';

import '../../components/custom_button.dart';
import '../../controller/order_controller.dart';

class WalletPayment extends StatefulWidget {
  final onsuccess;
  const WalletPayment({Key? key, this.onsuccess}) : super(key: key);

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {
  bool isLoading = false;
  final orderController = Get.find<OrderController>();
  late final TextEditingController _mobileController, _pinController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                    decoration: BoxDecoration(
                      //shadow

                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/pictures/khalti.png',
                              fit: BoxFit.cover,
                              width: 90,
                              height: 50,
                            ),
                          ),
                          Text('KHALTI', style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 24),
                          CustomTextField(
                            isPhoneNumber: true,
                            controller: _mobileController,
                            hintText: 'Mobile Number',
                            decoration: kBoxDecorationStyle,
                            icon: Icon(Icons.mobile_screen_share),
                          ),
                          const SizedBox(height: 24),
                          CustomTextField(
                            isPhoneNumber: true,
                            obscureText: true,
                            controller: _pinController,
                            hintText: 'PIN',
                            decoration: kBoxDecorationStyle,
                            icon: Icon(Icons.phone),
                          ),
                          const SizedBox(height: 24),
                          isLoading
                              ? CircularProgressIndicator()
                              : CustomButton(
                                  onTap: () => onPayment(),
                                  label: 'Proceed',
                                  color: Colors.green,
                                )
                        ],
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  void onPayment() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      isLoading = true;
    });
    final initiationModel = await Khalti.service.initiatePayment(
      request: PaymentInitiationRequestModel(
        amount: 1000,
        mobile: _mobileController.text,
        productIdentity: 'dasdasd',
        productName: 'dsa',
        transactionPin: _pinController.text,
        additionalData: {
          'orders': jsonEncode(orderController.orders.value),
          'manufacturer': '.',
        },
      ),
    );
    setState(() {
      isLoading = false;
    });

    final otpCode = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? _otp;
        return AlertDialog(
          title: const Text('OTP Sent!'),
          content: TextField(
            decoration: const InputDecoration(
              label: Text('OTP Code'),
            ),
            onChanged: (v) => _otp = v,
          ),
          actions: [
            SimpleDialogOption(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                Navigator.pop(context, _otp);
              },
            )
          ],
        );
      },
    );

    if (otpCode != null) {
      try {
        final model = await Khalti.service.confirmPayment(
          request: PaymentConfirmationRequestModel(
            confirmationCode: otpCode,
            token: initiationModel.token,
            transactionPin: _pinController.text,
          ),
        );
        orderController.placeOrder(transaction_token: model.token);

        debugPrint(model.toString());
      } catch (e) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
