import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Product {
  String? id;
  String? name;
  double? price;
  List<Color>? imageColorTheme;
  List<String>? imagePath;
  double numberStart;
  double width;
  double height;
  double length;
  String? category;
  String? description;
  String? caption;
  double weight;
  int? totalReview;
  List<String>? search;
  bool isHot;
  String? linkAR;
  DateTime? isDeleted;

  Product({
    this.id,
    this.name,
    this.price = 0,
    this.imagePath,
    this.imageColorTheme,
    this.height = 0,
    this.width = 0,
    this.length = 0,
    this.weight = 0,
    this.numberStart = 0,
    this.description = "",
    this.caption = "",
    this.totalReview,
    this.category = "",
    this.search,
    this.isHot = false,
    this.linkAR,
    this.isDeleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'price': this.price,
      'image_color_theme': toStringArray(),
      'image_path': this.imagePath,
      'category': this.category,
      'number_start': this.numberStart,
      'description': this.description,
      'caption': this.caption,
      'total_review': this.totalReview,
      'width': this.width,
      'height': this.height,
      'length': this.length,
      'search': this.search,
      'weight': this.weight,
      'is_hot': this.isHot,
      'is_deleted': (this.isDeleted != null) ? Timestamp.fromDate(this.isDeleted!) : null,
      'link_ar': this.linkAR
    };
  }

  factory Product.fromJson(Map<String, dynamic> data, String? id) {
    return Product(
      id: id,
      name: data["name"],
      price: data["price"] ?? 0,
      imagePath: data["image_path"] != null ? List<String>.from(data["image_path"]) : [],
      numberStart: data["number_start"] ?? 0,
      description: data["description"] ?? "",
      caption: data["caption"] ?? "",
      totalReview: data["total_review"] ?? 0,
      height: data["height"] ?? 0,
      width: data["width"] ?? 0,
      length: data["length"] ?? 0,
      weight: data["weight"] != null ? double.parse(data["weight"].toString()) : 0,
      category: data['category'] ?? "",
      imageColorTheme: data["image_color_theme"] != null ? Product().fromString(List<String>.from(data["image_color_theme"])) : [],
      search: data["search"] != null ? List<String>.from(data["search"]) : [],
      isHot: data['is_hot'] ?? false,
      linkAR: data['link_ar'],
      isDeleted: data['is_deleted'] != null ? DateTime.tryParse((data["is_deleted"] as Timestamp).toDate().toString()) : null,
    );
  }

  List<Color> fromString(List<String> colors) {
    List<Color> c = [];
    colors.forEach((element) {
      Color t = HexColor(element.replaceAll("0xff", "#"));
      c.add(t);
    });
    return c;
  }

  List<String> toStringArray() {
    List<String> c = [];
    (imageColorTheme ?? []).forEach((element) {
      // Color t = HexColor(element.replaceAll("0xff", "#"));
      c.add(element.toString().replaceAll("Color(", "").replaceAll(")", ""));
      // c.add(t);
    });
    return c;
  }
}
