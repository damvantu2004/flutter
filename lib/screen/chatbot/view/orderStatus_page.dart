import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/cart.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/chatbot/controller/chatbot_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/models/Order.dart';

// class OrderStatusPage extends StatelessWidget {
class OrderStatusPage extends GetView<ChatBotController> {
  List<MyOrder> orders = [];
  List<Cart> carts = [];
  List<Product> products = [];
  List<String> status = [];

  // OrderStatusPage({super.key});
  // OrderStatusPage({super.key, required List<Order> orders, required List<Cart> carts, required List<Product> products, required List<String> status});

  OrderStatusPage(
      {super.key,
      required this.orders,
      required this.carts,
      required this.products,
      required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: EdgeInsets.only(
          top: Get.height * 0.024,
          bottom: Get.height * 0.015,
          left: Get.height * 0.024,
          right: Get.height * 0.024),
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
        right: Get.width * 0.1 + 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: buttonColor,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 134,
            width: 380,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return odStatus(itemIndex, context);
                }),
          ),
        ],
      ),
    );
  }

  Container odStatus(int index, BuildContext context) {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (products[index].imagePath != null &&
                      products[index].imagePath!.length > 0)
                  ? SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.network(
                        products[index].imagePath![0].toString(),
                        fit: BoxFit.fill,
                      ),
                    )
                  : const SizedBox(height: 90, width: 90),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 170,
                    child: Text(
                      products[index].name.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${carts[index].amount} product',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text('Price :',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                          '\$${orders[index].priceTotal.toStringAsFixed(2)}'
                              .toString(),
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(status[index],
                      style: const TextStyle(fontSize: 12, color: Colors.red)),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: Get.height * 0.021,
                bottom: Get.height * 0.012,
                left: Get.height * 0.012,
                right: Get.height * 0.012),
            height: Get.height * 0.0002,
            color: textGrey1Color,
          ),
          InkWell(
              child: Container(
                height: Get.height * 0.021,
                width: Get.width,
                alignment: Alignment.center,
                child: Text(
                  select_od,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Get.height * 0.02,
                      color: buttonColor),
                ),
              ),
              onTap: () async {
                controller.loadDetailOrder(index);
              }),
        ],
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: SizedBox(
            height: Get.height * 0.01,
            width: Get.width * 0.01,
            child: SvgPicture.asset(icon_back, fit: BoxFit.scaleDown)),
      ),
    );
  }
}
