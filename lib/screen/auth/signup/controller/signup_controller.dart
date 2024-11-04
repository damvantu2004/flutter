import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/screen/bottom_bar/view/bottom_bar_page.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isPasswordHiddens = true.obs;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  String format(String st) {
    return st.trim();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void togglePasswordVisibilitys() {
    isPasswordHiddens.value = !isPasswordHiddens.value;
  }

  Future<void> signUp() async {
    final name = format(nameController.text);
    final email = format(emailController.text);
    final password = format(passwordController.text);
    final rePassword = format(rePasswordController.text);

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        rePassword.isEmpty) {
      showToast("Please fill in all fields.");
      return;
    }

    if (!isEmailValid(email)) {
      showToast("Invalid email format.");
      return;
    }

    if (password != rePassword) {
      showToast("Passwords do not match.");
      return;
    }

    if (password.length < 6) {
      showToast("Password must be at least 6 characters long.");
      return;
    }

    try {
      final user = await AuthService.signUp(name, email, password);
      if (user != null) {
        Get.to(const BottomBarPage());
        clearTextFields();
      } else {
        showToast("An error occurred. Please try again later.");
      }
    } catch (e) {
      showToast("An error occurred. Please try again later.");
      print("Sign Up Error: $e");
    }
  }

  bool isEmailValid(String email) {
    // Regular expression pattern to validate email format
    final emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  void clearTextFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
