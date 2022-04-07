import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/components/bottomnavbar.dart';
import 'package:fyp_saino/components/drawer.dart';
import 'package:fyp_saino/components/product_card.dart';
import 'package:fyp_saino/controller/product_controller.dart';
import 'package:fyp_saino/model/product_model.dart';
import 'package:fyp_saino/screens/account.dart';
import 'package:fyp_saino/screens/categories/vegetables.dart';
import 'package:fyp_saino/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static var routeName;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _currentIndex = 0;
final List<Widget> _children = [HomeScreen(), Account()];

class _HomeScreenState extends State<HomeScreen> {
  String token = "";
  @override
  void initState() {
    super.initState();
    getCred();
  }

  void getCred() async {
    //here we get fetch our credentials
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString('login')!;
    });
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
      drawer: AppDrawer(),
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
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.plus,
          size: 30,
        ),
        onPressed: () {},
        tooltip: "Post an ad",
        backgroundColor: kSecondaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
        padding: const EdgeInsets.all(10.0),
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
        child: Consumer<ProductContoller>(builder: (context, product, child) {
          return Row(
            children: [
              ...List.generate(
                product.demoProducts.length,
                (index) {
                  if (product.demoProducts[index].isPopular) {
                    return ProductCard(product: product.demoProducts[index]);
                  }
                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              const SizedBox(width: 20),
            ],
          );
        }),
      )
    ],
  );
}
