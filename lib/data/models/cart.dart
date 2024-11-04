import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Cart {
  String id;
  String idProduct;
  double price;
  Color? color;
  double width;
  double height;
  double length;
  int amount;

  Cart({this.id = "", this.idProduct = "", this.price = 0, this.height = 0, this.width = 0, this.length = 0, this.amount = 1, this.color});

  Map<String, dynamic> toJson() {
    return {
      'id_product': this.idProduct,
      'price': this.price,
      'height': this.height,
      'width': this.width,
      'length': this.length,
      'amount': this.amount,
      'color': this.color != null ? toStringFormat(this.color!) : "#000000", // Default to black if color is null
    };
  }

  factory Cart.fromJson(Map<String, dynamic> data, {String id = ""}) {
    return Cart(
      id: id,
      idProduct: data["id_product"] ?? "",
      price: data["price"] ?? 0,
      height: data["height"] ?? 0,
      width: data["width"] ?? 0,
      length: data["length"] ?? 0,
      amount: data["amount"] ?? 0,
      color: fromString(data["color"] ?? "#000000"), // Default to black if color is null
    );
  }

  static Color fromString(String color) {
    if (color.startsWith('#')) {
      if (color.length == 7 || color.length == 9) {
        return HexColor(color);
      } else {
        throw FormatException("Invalid color format, expected 7 or 9 characters.");
      }
    } else if (color.startsWith('Color(0x')) {
      color = color.replaceAll("Color(0x", "#").replaceAll(")", "");
      return HexColor(color);
    } else {
      throw FormatException("Invalid color format, expected # or Color(0x)");
    }
  }

  String toStringFormat(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }
}
