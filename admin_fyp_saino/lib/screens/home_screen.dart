import 'package:admin_fyp_saino/utilites.dart/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: const Text("Admin Dashboard")),
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
            ),
            child: Stack(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    foregroundImage: AssetImage('assets/images/admin.png'),
                    radius: 50,
                  ),
                ),
                Align(
                  alignment: Alignment.center + const Alignment(0, .7),
                  child: const Text(
                    'Test',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          _dashboard(context),
          _products(),
          _categories(context),
          _users(),
          _logout(context),
        ])));
  }

  Widget _dashboard(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.home),
      title: Text('Dashboard'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/home');
      },
    );

    return app;
  }

  Widget _logout(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.home),
      title: Text('Logout'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/logout');
      },
    );

    return app;
  }

  Widget _categories(BuildContext context) {
    var app = ListTile(
      leading: Icon(Icons.category),
      title: Text('Categories'),
      onTap: () {
        Navigator.popAndPushNamed(context, '/category');
      },
    );
    return app;
  }

  Widget _users() {
    var app = ListTile(
      leading: Icon(Icons.people),
      title: Text('Users'),
      onTap: () {},
    );
    return app;
  }

  Widget _products() {
    var app = ExpansionTile(
      leading: Icon(Icons.devices_other),
      title: Text('Products'),
      children: <Widget>[
        ListTile(
          title: Text('   Pending Products'),
          onTap: () {},
        ),
        ListTile(
          title: Text('   Approved Products'),
          onTap: () {},
        ),
        ListTile(
          title: Text('   Sold Products'),
          onTap: () {},
        ),
        ListTile(
          title: Text('   Inactive Products'),
          onTap: () {},
        ),
      ],
    );
    return app;
  }
}
