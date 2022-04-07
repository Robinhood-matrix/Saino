import 'package:flutter/material.dart';
import 'package:fyp_saino/model/product_model.dart';

class ProductContoller extends ChangeNotifier {
  List<Product> demoProducts = [
    Product(
      id: 1,
      images: [
        "assets/pictures/potato.jpg",
      ],
      colors: const [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      title: "Potatos™",
      price: 50.99,
      description: "hello",
      rating: 4.8,
      isFavourite: true,
      isPopular: true,
    ),
    Product(
      id: 2,
      images: [
        "assets/pictures/apple.jpg",
      ],
      colors: const [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      title: "Apples™",
      price: 130.99,
      description: "hello",
      rating: 4.8,
      isFavourite: true,
      isPopular: true,
    ),
    Product(
      id: 3,
      images: [
        "assets/pictures/mango.jpg",
      ],
      colors: const [
        Color(0xFFF6625E),
        Color(0xFF836DB8),
        Color(0xFFDECB9C),
        Colors.white,
      ],
      title: "Mangoes™",
      price: 80.99,
      description: "hello",
      rating: 4.8,
      isFavourite: true,
      isPopular: true,
    ),
  ];
}
