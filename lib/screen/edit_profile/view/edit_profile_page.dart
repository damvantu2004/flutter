import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/screen/profile/view/profile_page.dart';
import 'package:get/get.dart';
import '../../../data/paths/icon_path.dart';
import '../../../data/values/fonts.dart';
import '../../../data/values/strings.dart';
import '../../../data/values/colors.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../screen/edit_profile/controller/edit_profile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: _appBarCustom(),
        body: _bodyCustom(context),
      ),
    );
  }

  AppBar _appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: SvgPicture.asset(icon_back, fit: BoxFit.scaleDown),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        editProfileTitle,
        style: TextStyle(
          fontFamily: jose_fin_sans,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _bodyCustom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // selectedImage(),
          //showImage(),
          GestureDetector(
            onTap: () {
              controller.selectedImage();
            },
            child: Center(
              child: SizedBox(
                child: CircleAvatar(
                  backgroundColor: const Color(0xfff3e0a6),
                  radius: 50.0,
                  backgroundImage: controller.getAvatar(),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 12.0,
                      child: Icon(
                        Icons.camera_alt,
                        size: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: controller.fullNameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller.emailController,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller.addressController,
            enabled: false,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Address',
            ),
          ),
          const SizedBox(height: 15.0),

          btnUpdate('Update'),
        ],
      ),
    );
  }

  Container showImage() {
    return Container(
      width: Get.width,
      height: 85,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: _buildImage(),
    );
  }

  _buildImage() {
    if (controller.imagePath == null) {
      return Container();
    } else {
      return Image.file(File(controller.imagePath!), height: 85, width: 85, fit: BoxFit.cover);
    }
  }

  Widget btnUpdate(String title) {
    return InkWell(
      onTap: () {
        // if (controller.load == false)
        //controller.updateUser();
        controller.updateUser();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width,
        decoration: BoxDecoration(color: controller.load == false ? buttonColor : buttonColor.withOpacity(0.5), borderRadius: BorderRadius.circular(5), boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 4,
          )
        ]),
        child: Text(
          controller.load == false ? title : "Loading...",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Get.width * 0.051, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
