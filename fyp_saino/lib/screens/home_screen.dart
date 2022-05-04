import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fyp_saino/components/drawer.dart';
import 'package:fyp_saino/screens/MainScreen.dart';

import 'package:fyp_saino/screens/account.dart';
import 'package:fyp_saino/screens/cart_screen.dart';
import 'package:fyp_saino/screens/wishlist_screen.dart';

import 'package:fyp_saino/utilities/constants.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class HomeScreen extends StatefulWidget {
  static var routeName;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navKey,
        onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => TabBarView(controller: _tabController, children: [
                  MainScreen(),
                  WishlistScreen(),
                  CartScreen(),
                  Account(),
                ])),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.green.withOpacity(0.5),
        onTap: (index) {
          _tabController.animateTo(index);
          setState(() {});
        },
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.green,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.green,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            label: 'Profile',
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     FontAwesomeIcons.plus,
      //     size: 30,
      //   ),
      //   onPressed: () {
      //     Navigator.popAndPushNamed(context, '/admin');
      //   },
      //   tooltip: "Post an ad",
      //   backgroundColor: kSecondaryColor,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildCarousel() {
    final List<String> imagelist = [
      'assets/pictures/ad1.jpg',
      'assets/pictures/greenad.jpg',
      'assets/pictures/ad3.jpg'
    ];

    List<Widget> generateCarousel() {
      return imagelist
          .map((element) => ClipRRect(
                child: Image.asset(
                  element,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(15),
              ))
          .toList();
    }

    return Container(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Stack(children: [
          CarouselSlider(
            options: CarouselOptions(
                enlargeCenterPage: true,
                height: 200,
                autoPlay: true,
                aspectRatio: 18 / 8,
                autoPlayInterval: Duration(seconds: 4)),
            items: generateCarousel(),
          ),
        ]),
      ),
    );
  }

  Widget buildImage(String imageList, int index) => Container();
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
                press: () {
                  Navigator.popAndPushNamed(context, '/vegetables');
                },
              ),
              SpecialOfferCard(
                image: "assets/pictures/dairyAd.jpg",
                category: "Dairy Products",
                numOfBrands: 24,
                press: () {
                  Navigator.popAndPushNamed(context, '/dairy');
                },
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
    ],
  );
}
