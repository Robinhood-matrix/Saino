import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/utilities/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildScrollView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 40,
          child: Image.asset(
            "assets/pictures/ad1.jpg",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(7)),
          child: const Center(
            child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                    border: InputBorder.none)),
          ),
        ),
      ),
      drawer: Drawer(
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
            const ExpansionTile(
              leading: Icon(FontAwesomeIcons.leaf),
              title: Text('Vegetables'),
            ),
            const ExpansionTile(
              leading: Icon(FontAwesomeIcons.appleAlt),
              title: Text('Fruits'),
            ),
          ],
        ),
      ),
      body: buildCarousel(),
    );
  }

  Widget buildCarousel() {
    return Container(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true, autoPlayInterval: Duration(seconds: 4)),
            items: [
              Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/pictures/ad1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
