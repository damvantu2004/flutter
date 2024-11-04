import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/repository/search_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:furniture_app/screen/product_detail/view/product_detail_page.dart';
import 'package:furniture_app/screen/search_product/view/product_search_page.dart';
import 'package:get/get.dart';

import '../../../data/models/product.dart';

class SearchPageController extends GetxController {
  List<Product> products = [];
  late UserProfile currenUser;
  Product product1 = Product(
    name: "Black Simple Lamp",
    price: 12.0,
    imagePath: [
      "assets/images/product1.png",
      "assets/images/product1.png",
      "assets/images/product1.png"
    ],
    imageColorTheme: [Colors.red, Colors.black, Colors.blue],
    numberStart: 4.5,
    totalReview: 50,
    // review:
    //     "Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. "
  );
  List<String> searchtext = [];
  @override
  void onInit() {
    super.onInit();
    loadInit();
  }

  Future<void> loadInit() async {
    currenUser = await UserRepository().getUserProfile();
    searchtext = await SearchRepository().getMessSearch(limit: 4);
    products = await UserRepository().getProductSeemRecently(limit: 4);
    update();
  }

  Future<void> onRemove(index) async {
    //await SearchRepository().deletedProduct(searchtext[index].toString());
    searchtext.removeAt(index);
    update();
  }

  Future<void> clickProduct(Product product) async {
    currenUser = await UserRepository().getUserProfile();
    bool load = await Get.to(ProductDetailPage(), arguments: {
      "product": product,
      "favorite": currenUser.checkFavories(product.id.toString()),
      "cart": currenUser.checkCart(product.id.toString()),
    });
    if (load) currenUser = await UserRepository().getUserProfile();
  }

  Future<void> loadSearch(String text, {bool load = false}) async {
    try {
      if (text.isNotEmpty) {
        products = await ProductRepository().searchProducts(text);
        SearchRepository().addMessSearch(text);

        if (load) {
          update();
        } else {
          // Get.back();
          Get.to(ProductSearchPage());
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

}
