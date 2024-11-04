import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/cart.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:get/get.dart';

import '../../../data/models/Order.dart';

class DetailProductStatusPage extends StatelessWidget {
  MyOrder orders;
  Cart carts;
  Product product;

  String status;

  DetailProductStatusPage(
      {super.key,
      required this.orders,
      required this.carts,
      required this.product,
      required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.only(
          top: Get.height * 0.024,
          bottom: Get.height * 0.015,
          left: Get.height * 0.024,
          right: Get.height * 0.024),
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 10,
        left: Get.width * 0.1 + 10,
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 238, 238),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 98,
            width: 380,
            child: ListView.builder(
                itemCount: 1,
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
      //height: 150,
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
              (product.imagePath != null && product.imagePath!.length > 0)
                  ? SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.network(
                        product.imagePath![0].toString(),
                        fit: BoxFit.fill,
                      ),
                    )
                  : const SizedBox(height: 90, width: 90),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 170,
                    child: Text(
                      product.name.toString(),
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
                      Text('${carts.amount} product',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text('Price :',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('\$${orders.priceTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(status,
                      style: const TextStyle(fontSize: 12, color: Colors.red)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
