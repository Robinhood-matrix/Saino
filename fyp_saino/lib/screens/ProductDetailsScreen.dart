import 'package:flutter/material.dart';
import 'package:fyp_saino/components/custom_button.dart';
import 'package:fyp_saino/model/product_model.dart';
import 'package:fyp_saino/utilities/apis.dart';
import 'package:fyp_saino/utilities/constants.dart';
import 'package:get/get.dart';

import '../components/add_to_cart_bottomsheet.dart';
import '../controller/auth_controller.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  final Product product;
  int index;

  DetailScreen({required this.product, required this.index});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SafeArea(
                child: Column(
              children: [
                _itemImage(),
              ],
            )),
            Expanded(child: _bottomSheet()),
          ],
        ),
      ),
      bottomNavigationBar: _bottomAddToCart(),
    );
  }

  Widget _itemImage() {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
              height: 300,
              width: double.infinity,
              child: Hero(
                tag: widget.product.id + '_image',
                child: Image.network(
                  baseUrl + widget.product.image,
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            top: 15,
            left: 15,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.navigate_before,
                    color: AppColors.black,
                    size: 40,
                  ),
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  _bottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                widget.product.name,
                style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    letterSpacing: 1.1),
              ),
              Spacer(),
              Text(
                "\Rs: " + widget.product.price,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    fontFamily: "Raleway",
                    color: Colors.red),
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 2.5,
          ),
          SizedBox(height: 10),
          Text(
            "Product Description",
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.product.description,
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 2.5,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _bottomAddToCart() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white70, Colors.white],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        children: [
          Expanded(
              child: CustomButton(
            onTap: () {
              Get.bottomSheet(AddToCartBottomSheet(
                item: widget.product,
              ));
            },
            label: 'Add to cart',
            color: Colors.black,
          )),
        ],
      ),
    );
  }
}
