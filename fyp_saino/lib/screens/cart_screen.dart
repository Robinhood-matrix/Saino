import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fyp_saino/components/payment_bottomsheet.dart';
import 'package:fyp_saino/components/custom_button.dart';
import 'package:fyp_saino/controller/cart_controller.dart';
import 'package:fyp_saino/controller/order_controller.dart';
import 'package:fyp_saino/utilities/apis.dart';
import 'package:fyp_saino/utilities/constants.dart';

import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.find<CartController>();
  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Cart',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => Column(
                        children: cartController.cart.values.map((item) {
                          return menuItemCard(jsonDecode(item));
                        }).toList(),
                      )),
                ),
              ),
              Container(
                color: AppColors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() => cartController.cartTotal.value != 0.0
                      ? CustomButton(
                          onTap: () {
                            Get.bottomSheet(CartBottomSheet());
                          },
                          label: 'Buy Now: \Rs ' +
                              cartController.cartTotal.toString(),
                          color: Colors.green,
                        )
                      : SizedBox()),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }

  Widget menuItemCard(item) {
    final cartController = Get.find<CartController>();
    return Container(
      height: Get.width / 4.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        //shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                cartController.removeFromCart(item["id"]);
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Remove',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                child: Image.network(
                  baseUrl + item['image'],
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  width: Get.width / 4.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 1.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(item['name'].toString().toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600))),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '\Rs  ' + item['price'].toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.red),
                            )),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black87,
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(4, 4)),
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(-2, -2))
                      ],
                    ),
                    child: IconButton(
                        padding: EdgeInsets.only(right: 0),
                        color: Colors.white,
                        icon: const Icon(Icons.remove),
                        onPressed: () =>
                            cartController.decreaseQuantity(item: item)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item["quantity"].toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black87,
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(4, 4)),
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(-2, -2))
                      ],
                    ),
                    child: IconButton(
                        padding: EdgeInsets.only(right: 0),
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            cartController.increaseQuantity(item: item)),
                  ),
                ],
              ),
              const Spacer(),
              Text('\Rs  ' + item["lineTotal"].toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
