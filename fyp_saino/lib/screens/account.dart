import 'package:flutter/material.dart';
import 'package:fyp_saino/components/custom_button.dart';
import 'package:fyp_saino/controller/auth_controller.dart';
import 'package:get/get.dart';

class Account extends GetView<AuthController> {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  foregroundImage:
                      AssetImage('assets/pictures/testBahadur.jpg'),
                  radius: 90,
                ),
              ),

              SizedBox(height: 30),
              content(title: 'Name :', value: controller.user["name"]),
              content(title: 'Phone :', value: controller.user["phone"]),
              content(title: 'Email:', value: controller.user["username"]),
              content(title: 'Address :', value: controller.user["address"]),

              //logout
              SizedBox(height: 20),
              CustomButton(onTap: () => controller.logout(), label: 'Logout',color: Colors.black,),
              SizedBox(height: 20),
              CustomButton(
                  onTap: () => Get.toNamed('my-orders'), label: 'View Orders', color:Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget content({required String title, required String value}) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(title,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text(value,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
