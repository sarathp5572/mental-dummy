// To parse this JSON data, do
//
//     final getCategory = getCategoryFromJson(jsonString);

import 'dart:convert';

GetCategory getCategoryFromJson(String str) =>
    GetCategory.fromJson(json.decode(str));

String getCategoryToJson(GetCategory data) => json.encode(data.toJson());

class GetCategory {
  bool? status;
  String? text;
  List<Category>? category;

  GetCategory({
    this.status,
    this.text,
    this.category,
  });

  factory GetCategory.fromJson(Map<String, dynamic> json) => GetCategory(
        status: json["status"],
        text: json["text"],
        category: json["category"] == null
            ? []
            : List<Category>.from(
                json["category"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "text": text,
        "category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
      };
}

class Category {
  String? id;
  String? categoryName;
  String? categoryImg;

  Category({
    this.id,
    this.categoryName,
    this.categoryImg,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        categoryImg: json["category_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "category_img": categoryImg,
      };
}
