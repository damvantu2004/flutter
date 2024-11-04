import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/profile/view/profile_page.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/values/colors.dart';

class EditProfileController extends GetxController {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  TextEditingController addressController = TextEditingController();
  late File file;
  bool load = false;

  // Rx<File?> selectedImage = Rx<File?>(null);
  // RxString avatarUrl = RxString('');
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // String userId = '';
  late UserProfile users;
  ImagePicker _picker = ImagePicker();
  XFile? images;
  String? imagePath;

  @override
  void onInit() {
    super.onInit();
    users = Get.arguments;
    fullNameController = TextEditingController(text: users.name);
    emailController = TextEditingController(text: users.email);
  }



  void selectedImage() async {
    images = await _picker.pickImage(source: ImageSource.gallery);
    if (images != null) {
      imagePath = images!.path;
    } else {
      Get.snackbar("Fail", "No Image selected", snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: WHITE);
    }
    update();
  }

  void loadUpdateUser() {
    load = true;
    update();
  }

  Future<void> updateUser() async {
    loadUpdateUser();
    users.name = fullNameController.text;
    if (imagePath != null) users.avatarPath = imagePath;
    await UserRepository().updateUser(users, updateImage: imagePath != null);
    Fluttertoast.showToast(msg: "Update user profile successfull");
    Get.back(result: true);
  }
  //  Future<void> updateUserName( ) async {
  //   loadUpdateUser();
  //   UserProfile user = UserProfile(
  //     name: name.toString(),
  //     avatarPath: imagePath.toString(),
  //   );
  //   await UserRepository().updateUser(user);
  //   Fluttertoast.showToast(msg: "Update user profile successfull");
  //   Get.back();
  // }

  /* updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    // if (avatarUrl != null) {
    //   String url = await uploadImage(avatarUrl);
    //   map['avatar'] = url;
    //   print('iiiii' + url);
    // }
    map['name'] = fullNameController.text;
    map['email'] = emailController.text;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
        .update(map)
        .then((value) {});
    Navigator.pop(context);
    Get.to(ProfilePage());
    update();
  }*/

  getAvatar() {
    if (imagePath != null) return FileImage(File(imagePath.toString()));
    if (users.avatarPath != null) return NetworkImage(users.avatarPath!);
    return AssetImage('assets/images/avatar.png');
  }
}
