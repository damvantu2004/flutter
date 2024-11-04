// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:furniture_app/screen/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:get/get.dart';

class BottomBarPage extends GetView<BottomBarController> {
  const BottomBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.getBody(),
          bottomNavigationBar: _buildBottomBar(),
        ));
  }

  Container _buildBottomBar() {
    List<Widget> item = [];
    for (int i = 0; i < controller.icons_path.length; i++) {
      item.add(InkWell(
          onTap: () {
            controller.onChanged(i);
          },
          child: controller.getIcon(i)));
    }
    return Container(
      height: 40,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      margin: const EdgeInsets.only(top: 5, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: item,
      ),
    );
  }
}
