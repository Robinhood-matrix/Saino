import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:fyp_saino/screens/login_screen.dart';
import 'package:get/get.dart';


class AppDrawer extends GetView<AuthController> {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
            ),
            child: Stack(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    foregroundImage: AssetImage('assets/pictures/photo.png'),
                    backgroundColor: Colors.white,
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
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () => controller.logout(),
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
