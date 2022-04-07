import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/model/product_model.dart';

class ProductDetails extends StatefulWidget {
  final Product info;
  const ProductDetails({ Key? key,required this.info }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              // margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(135, 206, 235, 100),
              ),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 30, left: 18, right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Color(0xff00bfff)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 140),
                            child: Container(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert_sharp,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      )),

                  SizedBox(height: 150),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Container(child: Image.asset('assets/profile.png')),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 5, ),

                  SizedBox(
                    height: 20,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text("Book Now"),
          icon: const Icon(FontAwesomeIcons.bookBookmark),
        ));
  }
}
