// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/cart_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';

import 'package:furniture_app/screen/add_cart_option/view/add_cart_option_page.dart';
import 'package:get/get.dart';

import '../../../data/models/cart.dart';

class AddCartOption extends StatefulWidget {
  String idProduct;
  String imagePath;
  double price;
  int amount = 1;
  List<Color> colors = [];
  List<String> sizes = [];
  double height;
  double width;
  double lenght;
  int chooseColor = 0;
  bool load = false;

  AddCartOption(
      {Key? key,
      required this.idProduct,
      required this.imagePath,
      required this.price,
      required this.colors,
      required this.sizes,
      required this.height,
      required this.width,
      required this.lenght})
      : super(key: key);

  @override
  State<AddCartOption> createState() => AddCartOptionState();

  Future<void> addCart() async {
    // if (colors.isEmpty) {
    //   // Handle the error case where no colors are available.
    //   print("No colors available to add to cart.");
    //   return;
    // }

    Cart myCart = Cart(
        idProduct: idProduct,
        price: price,
        height: height,
        width: width,
        length: lenght,
        amount: amount,
        color: Colors.black); // Safe to access the color now

    print("This is add to cart");
    print(myCart);
    await CartRepository().addToCart(myCart);
  }

}
