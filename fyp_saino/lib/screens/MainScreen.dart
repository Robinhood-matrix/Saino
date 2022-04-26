import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
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
                    Obx(() => Container(
                        child: widget.controller.searched.trim() == ""
                            ? all()
                            : searched()))
                  ],
                )),
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
              color: AppColors.gray,
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
            height: 30,
            width: 20,
          ),
        )
      ],
    );
  }

  Widget _middleView() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColors.gray),
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
        ]);
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
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: AppColors.gray),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("All"),
                    )),
              ),
            ),
            Expanded(child: Container(height: 40, child: _horizontalList(5)))
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
                    // widget.controller.searched.value = e["category"];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: AppColors.gray),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e["category"]),
                        )),
                  ),
                ))
            .toList());
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
