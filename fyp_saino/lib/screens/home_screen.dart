import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/components/product_card.dart';
import 'package:fyp_saino/model/product_model.dart';
import 'package:fyp_saino/utilities/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            ListTile(
              leading: Icon(FontAwesomeIcons.leaf),
              title: Text('Vegetables'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.appleAlt),
              title: Text('Fruits'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.wineBottle),
              title: Text('Dairy'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.breadSlice),
              title: Text('Bread & Bakery'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCarousel(),
            Container(child: buildSpecialoffer()),
            const SizedBox(height: 10),
            buildPopularProduct()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        selectedItemColor: kPrimaryColor,
      ),
    );
  }

  Widget buildCarousel() {
    List<String> imagelist = [
      'assets/pictures/ad1.jpg',
      'assets/pictures/greenad.jpg'
    ];
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

  Widget buildSpecialoffer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Special for you",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "See More >",
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/pictures/ad1.jpg",
                category: "Vegetables",
                numOfBrands: 18,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/pictures/ad1.jpg",
                category: "Dairy Products",
                numOfBrands: 24,
                press: () {},
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 190,
          height: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.fitWidth,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildPopularProduct() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Popular Products",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "See More >",
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
              demoProducts.length,
              (index) {
                if (demoProducts[index].isPopular) {
                  return ProductCard(product: demoProducts[index]);
                }

                return const SizedBox
                    .shrink(); // here by default width and height is 0
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
      )
    ],
  );
}
