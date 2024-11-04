import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/auth/login/view/login_page.dart';
import 'package:furniture_app/screen/auth/signup/controller/signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (value) => Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.016),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              Column(
                children: [
                  Center(
                    child: Row(
                      children: [
                        const Spacer(),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.height * 0.01),
                            child: Container(
                              height: Get.height * 0.001,
                              width: Get.width * 0.3,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.13,
                          width: Get.width * 0.13,
                          child: Image.asset(logoPageAuth),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.height * 0.01),
                            child: Container(
                              height: Get.height * 0.001,
                              width: Get.width * 0.3,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.015),
                  SizedBox(
                    width: Get.width * 0.9,
                    child: Text(
                      titleSignUp,
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w700,
                        color: buttonColor,
                        fontSize: Get.width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.025),
                  Container(
                    margin: EdgeInsets.all(Get.width * 0.015),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(96, 96, 96, 0.2),
                          spreadRadius: 4,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(Get.width * 0.05),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.nameController,
                            decoration: const InputDecoration(
                              labelText: nameText,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          TextFormField(
                            controller: controller.emailController,
                            decoration: const InputDecoration(
                              labelText: emailText,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Obx(
                            () => TextField(
                              controller: controller.passwordController,
                              obscureText: controller.isPasswordHiddens.value,
                              decoration: InputDecoration(
                                hintText: passwordText,
                                suffix: InkWell(
                                  child: Icon(
                                    controller.isPasswordHiddens.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: Get.height * 0.025,
                                  ),
                                  onTap: () {
                                    controller.togglePasswordVisibilitys();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Obx(
                            () => TextField(
                              controller: controller.rePasswordController,
                              obscureText: controller.isPasswordHidden.value,
                              decoration: InputDecoration(
                                hintText: confirmPasswordText,
                                suffix: InkWell(
                                  child: Icon(
                                    controller.isPasswordHidden.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                    size: Get.height * 0.025,
                                  ),
                                  onTap: () {
                                    controller.togglePasswordVisibility();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.07),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 6,
                                    offset: Offset(1, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    controller.signUp();
                                  },
                                  child: Container(
                                    width: Get.width * 0.5,
                                    height: Get.height * 0.05,
                                    padding: EdgeInsets.all(Get.height * 0.015),
                                    child: const Text(
                                      signUp,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'JosefinSans',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.05),
                          Row(
                            children: [
                              const Spacer(),
                              const Text(
                                alreadyText,
                                style: TextStyle(
                                  fontFamily: 'JosefinSans',
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  signUp,
                                  style: TextStyle(
                                    fontFamily: 'JosefinSans',
                                    fontSize: Get.height * 0.02,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap: () {
                                  Get.to(LoginPage())?.then(
                                      (value) => controller.clearTextFields());
                                  controller.clearTextFields();
                                },
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.05),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
