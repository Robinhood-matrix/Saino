import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp_saino/components/drawer.dart';
import 'package:fyp_saino/components/product_tile.dart';
import 'package:fyp_saino/controller/categories_controller.dart';
import 'package:fyp_saino/controller/products_controller.dart';
import 'package:fyp_saino/utilities/constants.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatefulWidget {
  final controller = Get.find<ProductController>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final categoriesController = Get.find<CategoriesController>();
  var search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      _middleView(),
                      buildCarousel(),
                      SizedBox(
                        height: 10,
                      ),
                      _categories(),
                      _buildProducts(),
                      Obx(() => Container(
                          child: widget.controller.searched.trim() == ""
                              ? all()
                              : searched()))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget searched() {
    return Expanded(child: Container(
      child: GetX<ProductController>(builder: (productController) {
        return Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                children: [
                  for (var index = 0;
                      index < productController.filtered.length;
                      index++)
                    ProductTile(
                        is_wishlist: productController.isInWishlist(
                            product: productController.filtered[index]),
                        onWishlist: () => productController.addToWishlist(
                            product: productController.filtered[index]),
                        product: productController.filtered[index],
                        index: index)
                ],
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ));
      }),
    ));
  }

  Widget all() {
    return Expanded(child: Container(
      child: GetX<ProductController>(builder: (productController) {
        return Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                children: [
                  for (var index = 0;
                      index < productController.products.length;
                      index++)
                    ProductTile(
                        is_wishlist: productController.isInWishlist(
                            product: productController.products[index]),
                        onWishlist: () => productController.addToWishlist(
                            product: productController.products[index]),
                        product: productController.products[index],
                        index: index)
                ],
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ));
      }),
    ));
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Icon(
            Icons.navigate_before,
            color: AppColors.black,
          ),
        ),
        Container(
          child: SvgPicture.asset(
            "assets/logos/heart.svg",
            height: 10,
            width: 10,
          ),
        )
      ],
    );
  }

  Widget _middleView() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
      title:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: AppColors.grey),
          child: TextField(
            onChanged: (value) =>
                widget.controller.filterbySearch(search: value),
            cursorColor: AppColors.black,
            style: TextStyle(color: AppColors.black, fontSize: 16),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ]),
    );
  }

  Widget _categories() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Categories',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                widget.controller.filterbySearch(search: "");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: AppColors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 1.5,
                            blurRadius: 3,
                            offset: Offset(2, 3), // changes position of shadow
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("All"),
                    )),
              ),
            ),
            Expanded(child: Container(height: 45, child: _horizontalList(5)))
          ],
        )
      ],
    );
  }

  ListView _horizontalList(int n) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: categoriesController.categories.value
            .map((e) => InkWell(
                  onTap: () {
                    search = e["id"];
                    widget.controller.filterbySearch(search: e["id"]);
                    widget.controller.searched.value = e["category"];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6, left: 10, top: 4),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          color: AppColors.grey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 1.5,
                              blurRadius: 3,
                              offset:
                                  Offset(2, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e["category"]),
                        )),
                  ),
                ))
            .toList());
  }

  Widget _buildProducts() {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Products',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
          )),
    ]);
  }

  Widget buildCarousel() {
    final List<String> imagelist = [
      'assets/pictures/ad1.jpg',
      'assets/pictures/greenad.jpg',
      'assets/pictures/ad3.jpg',
      'assets/pictures/ad4.jpg',
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
      height: 200,
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
}
