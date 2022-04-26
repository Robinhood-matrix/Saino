import 'package:flutter/material.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/model/product_model.dart';
import 'package:fyp_saino/screens/DetailScreen.dart';
import 'package:fyp_saino/utilities/apis.dart';
import 'package:fyp_saino/utilities/constants.dart';

import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool is_wishlist;
  final onWishlist;
  final onAdminPress;
  final onProductDelete;
  final authController = Get.find<AuthController>();
  final int index;

  final List<Color> colors_light = <Color>[
    Color.fromARGB(255, 80, 238, 18),
    Color.fromARGB(255, 33, 209, 77),
    AppColors.light_blue,
    AppColors.light_pink,
    AppColors.light_green,
    AppColors.light_p
  ];
  final List<Color> colors_dark = <Color>[
    AppColors.dark_yellow,
    AppColors.dark_y,
    AppColors.dark_blue,
    AppColors.dark_pink,
    AppColors.dark_green,
    AppColors.dark_p
  ];

  ProductTile({
    Key? key,
    required this.product,
    required this.index,
    this.onAdminPress,
    this.onProductDelete,
    this.onWishlist,
    this.is_wishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailScreen(
          product: product,
          index: index,
        ));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 14, 172, 53),
                      Colors.white,
                    ]), // height: 200,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Hero(
                      tag: product.id + '_image',
                      child: Image.network(
                        baseUrl + product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  _itemTopView(index),
                  SizedBox(height: 2),
                  _columnOfDescription(index),
                  SizedBox(height: 5),
                  _bottomofItem(index),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
          if (authController.user.value["is_admin"] != '1')
            Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: !is_wishlist ? Colors.black : Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.favorite,
                        color: is_wishlist ? Colors.red : Colors.white),
                    onPressed: () => onWishlist(),
                  ),
                )),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              child: InkWell(
                onTap: () {
                  if (authController.user.value["is_admin"] == '1') {
                    onAdminPress();
                  } else {
                    // Get.bottomSheet(AddToCartBottomSheet(
                    //   item: product,
                    // ));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    authController.user.value["is_admin"] != '1'
                        ? Icons.shopping_bag
                        : Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemTopView(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 10, top: 2, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            product.name.toUpperCase(),
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Sora"),
          ),
          if (authController.user.value["is_admin"] == '1')
            InkWell(
              onTap: onProductDelete,
              child: CircleAvatar(
                backgroundColor: AppColors.light_pink,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _columnOfDescription(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 10, bottom: 0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              product.description,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Sora",
                height: 1.2,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomofItem(int index) {
    print(authController.user["is_admin"]);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            'Rs. ' + product.price.toString(),
            style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins"),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
