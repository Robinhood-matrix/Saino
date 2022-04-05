import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
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
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    foregroundImage:
                        AssetImage('assets/pictures/profilepic.jpg'),
                    radius: 50,
                  ),
                ),
                Align(
                  alignment: Alignment.center + const Alignment(0, .7),
                  child: const Text(
                    "Jessica Reynolds",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("reynoldJesicca32@gmail.com",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              "Browse By Category",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.leaf),
            title: Text('Vegetables'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/vegetables');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.appleAlt),
            title: Text('Fruits'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/fruits');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.wineBottle),
            title: Text('Dairy'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/dairy');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.breadSlice),
            title: Text('Grains'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/grains');
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.cow),
            title: Text('LiveStocks'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/livestocks');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
