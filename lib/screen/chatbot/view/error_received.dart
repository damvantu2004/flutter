// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:get/get.dart';

class ErrorReceivedPage extends StatelessWidget {
  const ErrorReceivedPage({super.key});

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
          SizedBox(height: Get.height * 0.006),
          const Text(
              "Try to ask if any of your relatives receive the goods for you! And if the order has not been sent to you, please contact us at the phone number",
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              style: TextStyle(fontSize: 15, color: textGrey)),
          const Text("Hotline: 19142793086.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textBlack2Color)),
          const Text(
              "We will contact the shipping unit to capture the information and will get back to you! Sorry for letting this happen !",
              maxLines: 3,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
        ],
      ),
    );
  }
}
