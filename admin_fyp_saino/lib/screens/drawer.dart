import 'package:flutter/material.dart';
import 'package:admin_fyp_saino/utilites.dart/constants.dart' as constants;

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    super.initState();
  }

  Color mainColor = constants.mainColor;
  Color secColor = constants.secTextColor;
  Color textColor = constants.textColor;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _drawerHeader(),
          _dashboard(context),
          _products(),
          _categories(context),
          _users(),
          _logout(context),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    var app = DrawerHeader(
      decoration: BoxDecoration(
        color: secColor,
      ),
      child: Container(
        child: Column(
          children: const <Widget>[
            Material(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              child: Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ),

      
          ],
        ),
      ),
    );
    return app;
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
      onTap: () {
        Navigator.popAndPushNamed(context, '/users');
      },
    );
    return app;
  }

  Widget _products() {
    var app = ExpansionTile(
      leading: Icon(Icons.devices_other),
      title: Text('Products'),
      children: <Widget>[
        ListTile(
          title: Text('Pending Products'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/pending');
          },
        ),
        ListTile(
          title: Text('   Approved Products'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/approved');
          },
        ),
        ListTile(
          title: Text('   Sold Products'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/sold');
          },
        ),
        ListTile(
          title: Text('   Inactive Products'),
          onTap: () {
            Navigator.popAndPushNamed(context, '/inactive');
          },
        ),
      ],
    );
    return app;
  }
}
