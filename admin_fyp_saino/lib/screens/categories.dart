import 'package:admin_fyp_saino/screens/drawer.dart';
import 'package:admin_fyp_saino/utilites.dart/constants.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {
  late Future<List<Category>> futurecat;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kPrimaryColor,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add, size: 30.0),
          onPressed: () {
            Navigator.of(context).pushNamed('/addCart');
          },
          tooltip: 'Add new Category',
        ),
        drawer: MyDrawer());
  }
}
