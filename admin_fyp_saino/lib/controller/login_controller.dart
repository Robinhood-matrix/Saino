import 'dart:convert';

import 'package:admin_fyp_saino/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends ChangeNotifier {
  var textusernameController = TextEditingController();
  var textPasswordController = TextEditingController();

  void login(BuildContext context) async {
    if (textPasswordController.text.isNotEmpty &&
        textusernameController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('http://192.168.1.74/admin/login.php'),
          body: ({
            'username': textusernameController.text,
            'password': textPasswordController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // Map<String, dynamic> user = body;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Token: ${body['token']}')));
        pageRoute(context, body['token']);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credential')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank')));
    }
  }

  void pageRoute(BuildContext context, String token) async {
    // Store value or token inside shared preference
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('login', token);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }
}
