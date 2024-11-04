import 'package:flutter/material.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/bottom_bar/view/bottom_bar_page.dart';
import 'package:furniture_app/screen/splash/controller/splash_controller.dart';
import 'package:furniture_app/screen/auth/login/view/login_page.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (value) => Scaffold(
              body: Container(
                child: buildBody(),
              ),
            ));
  }

  Widget buildBody() {
    return Stack(children: [
      Positioned(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Image.asset(image_boarding, fit: BoxFit.cover),
        ),
      ),
      Positioned(
        left: Get.width / 10,
        top: Get.height / 3.9,
        child: Text(
          title1.toUpperCase(),
          style: TextStyle(
              color: textGrey2Color,
              fontSize: Get.width * 0.07,
              fontWeight: FontWeight.w600,
              fontFamily: gelasio),
        ),
      ),
      Positioned(
        left: Get.width / 10,
        top: Get.height / 3.1,
        child: Text(
          title2.toUpperCase(),
          style: TextStyle(
              wordSpacing: 2,
              color: textBlack2Color,
              fontSize: Get.width * 0.09,
              fontFamily: gelasio,
              fontWeight: FontWeight.w700),
        ),
      ),
      Positioned(
        left: Get.width / 6,
        top: Get.height / 2.4,
        child: SizedBox(
          width: Get.width * 0.75,
          child: Text(
            title3,
            style: TextStyle(
                wordSpacing: 3.5,
                height: 2,
                color: textGrey3Color,
                fontSize: Get.width * 0.045,
                fontFamily: nunito_sans),
          ),
        ),
      ),
      Positioned(
        top: Get.width / 0.65,
        right: Get.width / 4,
        left: Get.width / 4,
        child: addButton(),
      )
    ]);
  }

  Widget addButton() {
    return InkWell(
      onTap: () {
        Get.back();
        Get.to(() => LoginPage());
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: ColorShadow,
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: Text(button_boarding,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.width * 0.051,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
    );
  }
}
