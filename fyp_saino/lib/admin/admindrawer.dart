import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/admin/add_category.dart';
import 'package:fyp_saino/admin/admin_orders.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDrawer extends GetView<AuthController> {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(170, 74, 33, 7),
            ),
            child: Stack(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    foregroundImage:
                        AssetImage('assets/pictures/testBahadur.jpg'),
                    radius: 50,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome!!!",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft + const Alignment(0, 0.5),
                  child: content(value: controller.user["name"]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              "Admin",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ListTile(
              leading: Icon(FontAwesomeIcons.plus),
              title: Text('Add Category'),
              onTap: () {
                Get.bottomSheet(
                    AddCategory(categoryController: TextEditingController()));
              }),
          ListTile(
              leading: Icon(FontAwesomeIcons.linesLeaning),
              title: Text('View Orders'),
              onTap: () => Get.to(AdminOrders())),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () async {
              SharedPreferences pre = await SharedPreferences.getInstance();
              await pre.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget content({required String value}) {
    return Container(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(value,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
