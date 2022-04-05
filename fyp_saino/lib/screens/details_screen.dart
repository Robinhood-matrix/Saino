import 'package:flutter/material.dart';
import 'package:fyp_saino/components/drawer.dart';
import 'package:fyp_saino/utilities/constants.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back_ios),
          )),
      body: body(),
    );
  }
}

Widget body() {
  return Column(
    children: [
      SizedBox(
        width: 280,
        child: AspectRatio(
          aspectRatio: 0.9,
          child: Image.asset('assets/pictures/potato.jpg'),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buildSmallPreview()],
      ),
      Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [Text('Product Title'), Text('Rs40.00')]),
        ),
      ),
    ],
  );
}

GestureDetector buildSmallPreview() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.only(right: 15),
      height: 48,
      width: 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor)),
      child: Image.asset(
        'assets/pictures/potato.jpg',
        fit: BoxFit.cover,
      ),
    ),
  );
}
