import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/cart_repository.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/screen/checkout/view/checkout_page.dart';
import 'package:get/get.dart';

import '../../../data/models/cart.dart';

class CartController extends GetxController {
  List<Cart> carts = [];
  List<Product> products = [];
  TextEditingController voucher = TextEditingController();
  List<bool> check = [];
  int dem = 0;
  bool all = false;
  double total = 0;
  List<int> number = [];
  bool loadCheckout = false;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void updateCheckPoint(int index) {
    check[index] = !check[index];
    if (check[index]) {
      dem = dem + 1;
      total = total + number[index] * products[index].price!;
    } else {
      dem = dem - 1;
      total = total - number[index] * products[index].price!;
    }
    if (!check[index] && check[index] != all) {
      all = check[index];
    } else if (dem == carts.length) {
      all = true;
    }
    update();
  }

  void updateCheckPointAll() {
    all = !all;
    total = 0;
    if (all) {
      dem = carts.length;
      for (int i = 0; i < carts.length; i++) {
        total = total + number[i] * products[i].price!;
      }
    } else {
      dem = 0;
    }
    check = List.filled(carts.length, all);
    update();
  }

  Future<void> clickButtonCheckOut() async {
    List<Cart> c = [];
    List<Product> p = [];
    for (int i = 0; i < check.length; i++) {
      if (check[i]) {
        Cart j = carts[i];
        j.amount = number[i];
        c.add(j);
        p.add(products[i]);
      }
    }
    if (c.length > 0) {
      var result = await Get.to(const CheckoutPage(), arguments: {
        'carts': c,
        'products': p,
      });
      if (result == "Reload list cart") {
        loadData();
      }
    }
  }

  Future<void> loadData() async {
    carts = await CartRepository().getAllMyCarts();
    total = 0;
    for (int i = 0; i < carts.length; i++) {
      print(carts[i].idProduct.toString());
      Product product = await ProductRepository().getProduct(carts[i].idProduct.toString());
      products.add(product);
      number.add(carts[i].amount);
    }
    check = List.filled(carts.length, false);
    update();
  }

  void subtractNumber(index) {
    if (number[index] == 1) return;
    number[index] = number[index] - 1;
    if (check[index]) total = total - carts[index].price;
    update();
  }

  void plusNumber(index) {
    number[index] = number[index] + 1;
    if (check[index]) total = total + carts[index].price;
    update();
  }

  Future<void> onRemove(index) async {
    await CartRepository().deleteCart(carts[index].id);
    loadData();
  }
}
