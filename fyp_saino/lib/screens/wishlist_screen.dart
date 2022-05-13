import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/add_to_cart_bottomsheet.dart';
import '../controller/products_controller.dart';
import '../utilities/apis.dart';

class WishlistScreen extends StatelessWidget {
  final productController = Get.find<ProductController>();
  WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'WishList',
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
            child: Obx(() => productController.wishlist.length == 0
                ? Center(
                    child: Text('No items in wishlist'),
                  )
                : ListView.builder(
                    itemCount: productController.wishlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: Get.width / 3.2,
                            decoration: BoxDecoration(
                              //shadow
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 82, 81, 81),
                                  blurRadius: 6,
                                  offset: Offset(5, 6),
                                ),
                              ],
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: Get.width / 4.8,
                                    child: Image.network(baseUrl +
                                        productController
                                            .wishlist[index].image),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              productController
                                                  .wishlist[index].name
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '\Rs ${productController.wishlist[index].price}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              designedButton('Remove', () {
                                                productController
                                                    .removeFromWishList(
                                                        product:
                                                            productController
                                                                    .wishlist[
                                                                index]);
                                              }),
                                              SizedBox(width: 10),
                                              designedButton('Add To Cart', () {
                                                Get.bottomSheet(
                                                    AddToCartBottomSheet(
                                                  item: productController
                                                      .wishlist[index],
                                                ));
                                              }),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }

  Widget designedButton(String text, Function onPressed) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          //shadow
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
