import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  List<String> tab = [
    'Ordered',
    'Preparing',
    'Delivered',
    'Completed',
  ];
  List<String> status = [
    'Ordered',
    'Preparing',
    'Delivery in progress',
    'Completed',
  ];
  Rx<int> tabCurrentIndex = 0.obs;
  List<MyOrder> totalOrder = [];
  List<MyOrder> orders = [];
  bool loadPage = true;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    totalOrder = await OrderRepository().getOrders();
    ChangedTab(tabCurrentIndex.value);
  }

  Color getColorStatusCourse(String str) {
    if (str == 'Processing') return textBlackColor;
    if (str == 'Canceled') return textGreyColor;
    return textGreenColor;
  }

  void ChangedTab(int index) {
    if (loadPage == false) {
      loadPage = true;
      update();
    }
    tabCurrentIndex.value = index;
    orders = [];
    for (int i = 0; i < totalOrder.length; i++) {
      if (OrderRepository.statusOrderToString(totalOrder[i]) == status[index]) {
        orders.add(totalOrder[i]);
      }
    }

    loadPage = false;
    update();
  }

  int getQuantity(MyOrder order) {
    int re = 0;
    for (int i = 0; i < order.carts.length; i++) {
      re += order.carts[i].amount;
    }
    return re;
  }
}
