import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/password/change_password/change-password_controller.dart';
import 'package:furniture_app/screen/profile/view/profile_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ChangePassword extends GetView<ChangePasswordController> {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: Container(
                color: backgroundColor,
                child: buildBody(),
              ),
            ));
  }

  Widget buildBody() {
    return Container(
      color: backgroundColor,
      width: Get.width,
      height: Get.height,
      padding: EdgeInsets.only(
        left: Get.height * 0.02,
        right: Get.height * 0.02,
      ),
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.02),
          enterPassword(old_pw, enter_old_pw, controller.oldPasswordController),
          SizedBox(height: Get.height * 0.02),
          enterPassword(new_pw, enter_new_pw, controller.newPasswordController),
          SizedBox(height: Get.height * 0.02),
          enterPassword(confirm_pw, enter_new_pw, controller.confirmPasswordController),
          SizedBox(height: Get.height * 0.038),
          addSave(),
        ],
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: IconButton(
        onPressed: () => Get.to(ProfilePage()),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Text(
        sub_password,
        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget enterPassword(String title, String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusColor: Colors.grey,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: buttonColor),
          ),
          border: UnderlineInputBorder(),
          hintText: hintText,
          labelText: title,
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {},
          ),
          prefixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? Colors.black : Colors.grey)),
      obscureText: true,
      textInputAction: TextInputAction.done,
    );
  }

  Widget addSave() {
    return InkWell(
      onTap: () {},
      child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(10), boxShadow: const [
            BoxShadow(
              color: ColorShadow,
              blurRadius: 10,
              spreadRadius: 4,
            )
          ]),
          child: Text(save.toUpperCase(), textAlign: TextAlign.center, style: TextStyle(fontFamily: jose_fin_sans, fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: Colors.white))),
    );
  }
}
