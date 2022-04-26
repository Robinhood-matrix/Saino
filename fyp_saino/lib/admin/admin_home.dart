import 'package:flutter/material.dart';
import 'package:fyp_saino/admin/add_category.dart';
import 'package:fyp_saino/admin/admin_orders.dart';
import 'package:fyp_saino/admin/admindrawer.dart';

import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/controller/categories_controller.dart';
import 'package:fyp_saino/utilities/commons.dart';

import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final controller = Get.find<CategoriesController>();
  AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(170, 74, 33, 7),
        title: Text('Admin Panel'),
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
      drawer: AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            //add category button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  cardTile(
                      label: 'Add Category',
                      icon: Icon(Icons.add),
                      onTap: () => Get.bottomSheet(AddCategory(
                          categoryController: TextEditingController()))),
                  cardTile(
                      label: 'View Orders',
                      icon: Icon(Icons.list),
                      onTap: () => Get.to(AdminOrders()))
                ],
              ),
            ),

            //getbuilder for categories
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
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              )
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
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category['category']),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Get.bottomSheet(AddCategory(
                        isEdit: true,
                        categoryController: TextEditingController(
                          text: category['category'],
                        ),
                        id: category['id'],
                      ));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                       //controller.deleteCategory(category['id']);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
