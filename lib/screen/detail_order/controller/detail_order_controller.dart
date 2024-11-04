import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:get/get.dart';

import 'package:jiffy/jiffy.dart';
import '../../../data/models/Order.dart';

class DetailOrderController extends GetxController {
  MyOrder? order;
  String status = "";
  List<Product> products = [];
  void onInit() {
    super.onInit();
    update();
    if (Get.arguments['order'] != null) {
      order = Get.arguments['order'];
      status = OrderRepository.statusOrderToString(order!);
    }
    loadProduct();
  }

  Future<void> loadProduct() async {
    if (order != null) {
      for (int i = 0; i < order!.carts.length; i++) {
        Product p = await ProductRepository().getProduct(order!.carts[i].idProduct);
        products.add(p);
      }
      update();
    }
  }

  Color getColorStatusCourse(String str) {
    if (str == 'Processing') return textBlackColor;
    if (str == 'Canceled') return textGreyColor;
    return textGreenColor;
  }

  bool checkGuarantee() {
    if (status == "Completed") {
      DateTime date = Jiffy.parse(order!.status[3].date as String).add(months: 6).dateTime;
      if (date.isAfter(DateTime.now())) return true;
    }
    return false;
  }

  bool checkReview() {
    if (status == "Completed") {
      DateTime date = Jiffy.parse(order!.status[3].date as String).add(days: 3).dateTime;
      if (date.isAfter(DateTime.now())) return true;
    }
    return false;
  }
}
