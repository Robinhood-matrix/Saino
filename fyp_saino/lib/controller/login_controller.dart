import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:fyp_saino/screens/home_screen.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends ChangeNotifier {
  var textEmailController = TextEditingController();
  var textUsernameController = TextEditingController();
  var textPasswordController = TextEditingController();

  void login(BuildContext context) async {
    if (textPasswordController.text.isNotEmpty &&
        textEmailController.text.isNotEmpty &&
        textPasswordController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('http://192.168.1.68/saino/users/login.php'),
          body: ({
            'email': textEmailController.text,
            'username': textEmailController.text,
            'password': textPasswordController.text
          }));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        // Map<String, dynamic> user = body;
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('username: ${body['username']}')));
        pageRoute(context, body['id']);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credential')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Blank')));
    }
  }

  Future login1(context) async {
    var url = "http://192.168.1.74/saino/users/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": textEmailController.text,
      "username": textUsernameController.text,
      "password": textPasswordController.text
    });

    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: '${response.body}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
      pageRoute(context, 'success');
      // Navigator.push(
      //     context, MaterialPageRoute(builder: ((context) => HomeScreen())));
    } else {
      Fluttertoast.showToast(
          msg: 'Username or Password  Incorrect!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          fontSize: 16.0);
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
