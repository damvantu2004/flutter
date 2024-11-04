import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/screen/edit_profile/view/edit_profile_page.dart';
import 'package:furniture_app/screen/setting/controller/setting_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../password/change_password/change_password_page.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        builder: (value) => Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBarCustom(),
          body: buildBody(),
        ));
  }

  Widget buildBody() {
    return Container(
      padding: EdgeInsets.only(
        left: Get.height * 0.024,
        right: Get.height * 0.024,
      ),
      color: backgroundColor,
      width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleEdit(personalInfo, icon_edit, () async {
              var result = await Get.to(EditProfilePage(), arguments: controller.users);
              if (result) controller.loadPage();
            }),
            infoSetting(name, controller.users.name.toString()),
            SizedBox(
              height: Get.height * 0.017,
            ),
            infoSetting(email, controller.users.email.toString()),
            const SizedBox(
              height: 10,
            ),
            titleEdit(password, icon_edit, () {
              Get.to(() => ChangePassword());
            }),
            infoSetting(password, '******'),
            const SizedBox(
              height: 10,
            ),
            titleEdit(notifications, null, null),
            notiOptions(sales, true),
            SizedBox(height: Get.height * 0.01),
            notiOptions(newArrivals, true),
            SizedBox(height: Get.height * 0.01),
            notiOptions(deliveryStatus, true),
            const SizedBox(
              height: 10,
            ),
            titleEdit(helpCenter, null, null),
            notiOptions(faq, null),
          ],
        ),
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: SvgPicture.asset(icon_back, fit: BoxFit.scaleDown),
        onPressed: () {
          Get.back(result: controller.load);
        },
      ),
      title: Text(
        setting,
        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
      ),
    );
  }

  Widget titleEdit(String? nameTitle, String? icon, Function? onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nameTitle.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: jose_fin_sans,
            color: Colors.grey,
          ),
        ),
        if (icon != null && icon.isNotEmpty) // Check if icon is not null or empty
          IconButton(
            onPressed: onPressed as void Function()?,
            icon: SvgPicture.asset(
              icon,
              fit: BoxFit.scaleDown,
              color: Colors.grey,
            ),
          )
      ],
    );
  }

  Widget infoSetting(String title, String content) {
    return Container(
      width: Get.width,
      height: Get.height * 0.076, // Consider reducing this if needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Get.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Flexible( // Makes the content flexible
              child: Text(
                title.toString(),
                style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.005),
            Flexible( // Makes the content flexible
              child: Text(
                content.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notiOptions(String title, bool? option) {
    return Container(
      width: Get.width,
      height: Get.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(Get.height * 0.017),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toString(),
                style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              option == true
                  ? Switch(
                value: controller.isSwitched,
                onChanged: (bool value) {
                  controller.onSwitchedType(value);
                },
                activeTrackColor: Colors.green,
                activeColor: Colors.white,
              )
                  : IconButton(
                padding: EdgeInsets.only(bottom: Get.height * 0.017),
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
              )
            ]
        ),
      ),
    );
  }
}
