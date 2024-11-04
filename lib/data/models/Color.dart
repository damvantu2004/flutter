import 'package:flutter/material.dart';

class Filter {
  late String type;
  late double price;
  late List<Color> color;
  Filter(
      {
      required this.price,
      required this.type,
      required this.color,
     });
}
