import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(
    json.decode(str).map((category) => Category.fromJson(category)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryStatus,
  });

  String categoryId;
  String categoryName;
  String categoryStatus;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryStatus: json["category_status"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_status": categoryStatus,
      };
}
