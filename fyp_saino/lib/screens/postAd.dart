import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostAd extends StatefulWidget {
  const PostAd({Key? key}) : super(key: key);

  @override
  State<PostAd> createState() => _PostAdState();
}

class _PostAdState extends State<PostAd> {
  //editing controller
  final TextEditingController title = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();

  final maxLines = 5;

  Widget _buildTitleTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0, left: 20),
              hintText: 'Ad Title*',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextFormField(
            controller: category,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0, left: 20),
              hintText: 'Category*',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextFormField(
            controller: location,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0, left: 20),
              hintText: 'Location*',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: maxLines * 30,
          child: TextField(
            controller: description,
            maxLines: maxLines,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0, left: 20),
              hintText: 'Description*',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: TextField(
            controller: price,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0, left: 20),
              hintText: 'Price*',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPicker() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xFF0f2005)),
        onPressed: () {},
        child: Text("Choose Image"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF4CAF50), title: Text("Post Ad")),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 80.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTitleTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildCategoryTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildLocationTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildDescriptionTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPriceTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPicker()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Publish Ad"),
        backgroundColor: Color(0xFFd63f29),
        splashColor: Color.fromARGB(255, 134, 55, 41),
        onPressed: () {},
      ),
    );
  }
}
