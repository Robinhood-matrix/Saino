import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/admin/add_category.dart';
import 'package:fyp_saino/admin/admin_orders.dart';

import 'package:fyp_saino/admin/admindrawer.dart';

import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/controller/categories_controller.dart';
import 'package:fyp_saino/utilities/commons.dart';

import 'package:get/get.dart';

class AddHome extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final controller = Get.find<CategoriesController>();
  AddHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Get.toNamed('/home');
          },
        ),
        backgroundColor: Colors.green,
        title: Text('Add Products'),
        actions: [
          Align(
            alignment: Alignment.bottomRight,
            child: PopupMenuButton<int>(
              offset: Offset(
                20,
                50,
              ),
              color: Colors.white,
              //action icon
              icon: const Icon(Icons.more_vert),
              //onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                popMenuItem('Logout', onTap: () async {
                  authController.logout();
                }),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text('Categories', style: TextStyle(fontSize: 18)),
                )),
            Obx(() => Wrap(
                  children: controller.categories.value
                      .map((e) => categoryTile(e))
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }

  Widget cardTile(
      {required String label,
      required Widget icon,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          width: Get.width / 3 - 8 * 3,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                  spreadRadius: 3,
                  offset: Offset(4, 4)),
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(-4, -4)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [icon, Text(label)],
          ),
        ),
      ),
    );
  }

  Widget categoryTile(category) {
    return InkWell(
      onTap: () => Get.toNamed('/product-screen', arguments: category['id']),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: Get.width / 3 - 8 * 3,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                  spreadRadius: 3,
                  offset: Offset(4, 4)),
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(-4, -4)),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category['category']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
