import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:get/get.dart';

import '../../../data/models/cart.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repository/cart_repository.dart';
import '../../../data/repository/user_repository.dart';

class FavoriteController extends GetxController {
  List<Product> products = [];
  List<Cart> carts = [];

  late UserProfile currenUser;
  @override
  void onInit() {
    super.onInit();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    carts = await CartRepository().getAllMyCarts();

    currenUser = await UserRepository().getUserProfile();
    for (int i = 0; i < (currenUser.favories ?? []).length; i++) {
      products
          .add(await ProductRepository().getProduct(currenUser.favories![i]));
      update();
    }
  }

  void deleteItemWithIndex(int index) {
    UserRepository().updateFavorite(products[index].id.toString(), false);
    products.removeAt(index);
    update();
  }

  void addItemWithIndex(int index) {
    // products.removeAt(index);
    // update();
  }
}
