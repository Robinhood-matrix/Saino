import 'package:admin_fyp_saino/model/categorymodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class CategoryContoller extends ChangeNotifier {
  //get
  Future<List<Category>> fetchCategory() async {
    var url = "http://192.168.1.74/saino/admin/categories.php";
    var response = await http.get(Uri.parse(url));
    return categoryFromJson(response.body);
  }
}
