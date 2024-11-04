// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:get/get.dart';

class OrderErrorPage extends StatelessWidget {
  const OrderErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.024),
      margin: EdgeInsets.only(
        top: 14,
        bottom: 14,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Why can't I place an order?",
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.height * 0.025,
                  color: Colors.black),
            ),
          ),
          const Divider(),
          SizedBox(height: Get.height * 0.006),
          const Text("I'm sorry about this, you can :",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          const Text("- Contact us to make an order.",
              textAlign: TextAlign.justify,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          const Text("Hotline: 19142793086.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textBlack2Color)),
          const Text(
              "- If you have a need to make a custom product, please fill in your correct phone number because we will call you to confirm.",
              maxLines: 3,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
        ],
      ),
    );
  }
}
