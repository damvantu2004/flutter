import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/profile/controller/profile_controller.dart';
import 'package:furniture_app/screen/setting/view/setting_page.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../order/view/order_page.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: buildBody(controller.users),
            ));
  }

  Container buildBody(UserProfile user) {
    return Container(
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.getAvatar(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.users.name.toString(),
                        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Text(
                        controller.users.email.toString(),
                        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w400, fontSize: 14, color: hintTextColor),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            cardProfile(my_orders, 'Already have ${controller.count} orders', () {
              Get.to(() => OrderPage());
            }),




            cardProfile(setting, sub_setting, () async {
              var result = await Get.to(() => const SettingPage(), arguments: controller.users);
              if (result) controller.loadData();
            }),
            buttonLogout(),
          ]),
        ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      actions: [

      ],
      title: SizedBox(
        width: Get.width,
        child: Text(
          profile,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w800, fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  Widget cardProfile(String title, String subText, Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: Get.width * 4,
        height: Get.height * 0.11,
        child: Card(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 17),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toString(),
                  style: TextStyle(fontFamily: jose_fin_sans, fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  subText.toString(),
                  style: TextStyle(fontFamily: jose_fin_sans, fontSize: 14, fontWeight: FontWeight.w400, color: hintTextColor),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  InkWell buttonLogout() {
    return InkWell(
      onTap: () {
        controller.logout();
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.only(bottom: 20, left: Get.width - 90, right: 20, top: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(50)), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 7,
            blurRadius: 10,
          ),
        ]),
        child: SvgPicture.asset(
          icon_out,
          fit: BoxFit.scaleDown,
          color: Colors.grey,
        ),
      ),
    );
  }
}
