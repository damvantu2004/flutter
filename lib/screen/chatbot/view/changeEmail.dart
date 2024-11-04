// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:get/get.dart';

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key});

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
              title,
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w600,
                  fontSize: Get.height * 0.025,
                  color: Colors.black),
            ),
          ),
          const Divider(),
          SizedBox(height: Get.height * 0.006),
          const Text("We are very sorry for this problem.",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          const Text(
              "Currently, our application does not allow customers to change their account email by themselves.",
              textAlign: TextAlign.justify,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          const Text(
              "If you want to change your email, please contact our Customer Service to change your email.",
              maxLines: 3,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          const Divider(),
          const Text("Hotline: 19142793086.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textBlack2Color)),
        ],
      ),
    );
  }
}
