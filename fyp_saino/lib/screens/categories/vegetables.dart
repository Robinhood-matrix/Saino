import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_saino/components/drawer.dart';
import 'package:fyp_saino/screens/home_screen.dart';
import 'package:fyp_saino/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class Vegetables extends StatefulWidget {
  @override
  _VegetablesState createState() => _VegetablesState();
}

class _VegetablesState extends State<Vegetables> {
  String id = '';
  //AddCart obj=AddCart();

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Vegetables'),
      centerTitle: true,
    );
  }

  int _value = 1;
  bool visible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future addCart(String user_id, String product_id, String quantity,
      String owner_id, String price) async {
    String selected_quantity = '';
    var total_amount = (num.parse(quantity)) * (num.parse(price));

    var url = 'https://diffused-props.000webhostapp.com/addcart.php';
    var data = {
      'user_id': user_id,
      'product_id': product_id,
      'quantity': quantity,
      'owner_id': owner_id,
      'selected_quantity': selected_quantity,
      'total_amount': total_amount
    };

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    //var message = jsonDecode(response.body);
    var message = await json.decode(json.encode(response.body));

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          title: new Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List data = [];
  Future product() async {
    var url =
        "https://diffused-props.000webhostapp.com/Categories/clothing.php";
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
        body: Column(children: [
          Expanded(
            //InkWell(

            child: FutureBuilder(
              future: product(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }

                return snapshot.hasData
                    ? ListView.builder(itemBuilder: (context, index) {
                        return Card(
                          elevation: 10,
                          color: Colors.greenAccent[100],

                          margin: const EdgeInsets.only(top: 10.0),
                          //  child: Padding(
                          // padding: const EdgeInsets.all(20.0),
                          // padding: EdgeInsets.fromLTRB(12, 12, 12, 12),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              InkWell(
                                
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    padding: EdgeInsets.all(40),

                                    // child: Image.network(  "https://diffused-props.000webhostapp.com/uploads/${list[index]['image']}"),
                                  ),
                                  onTap: () {
                                    
                                    //obj3.productDetail(list[index]['product_id']);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductInfoHome()),);
                                    //productId(list[index]['product_id'],list[index]['product_name']);
                                  }),

                              Column(
                                children: [
                                  Row(children: <Widget>[
                                    //Text('Product Name: '),
                                    // Expanded(child:
                                    // Text(list[index]['product_name']),
                                  ]),
                                  Row(children: <Widget>[
                                    // Text('        '),
                                    Text(
                                      'Product Title',
                                    ),
                                    // Text(list[index]['quantity']),
                                  ]),

                                  Row(children: <Widget>[
                                    Text('        '),
                                  ]),
                                  Text('Price: Rs '),
                                  // Text(list[index]['product_price']),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Buyer desc')
                                ],
                              ),

                              // ],
                              // ),

                              // Column(
                              //     children: <Widget>[

                              //       //  Text('        '),
                              //       //Text('Condition'),
                              //       Text(list[index]['product_condition'],
                              //         style: TextStyle(
                              //             color: Colors.red
                              //         ),),

                              //     ]
                              // ),
                              // Column(

                              //   children: <Widget>[

                              //     Center(
                              //         child: IconButton(
                              //             icon: Icon(Icons.add_shopping_cart,color: Colors.red,),
                              //             //child: Text('Add to cart'),
                              //             onPressed: () {
                              //               id = Provider.of<UserProvider>(context, listen: false).id;
                              //               print("i am $id");

                              //               addCart(id, list[index]['product_id'], list[index]['quantity'], list[index]['owner_id'],list[index]['product_price']);
                              //             }

                              //         )
                              //     )
                              //   ],
                              // )
                            ],

                            // ),
                            // )
                          ),
                        );
                      })
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          )
        ]));
  }
}
