import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/screen/bottom_bar/view/bottom_bar_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  var isPasswordHidden = true.obs;
  var isLoading = false.obs; // Add loading state variable

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void login() {
    String email = format(emailController.text);
    String password = format(passwordController.text);

    if (email.isEmpty || password.isEmpty) {
      showToast("Please fill in all fields.");
      return;
    }

    _signInWithEmailAndPassword(email, password);
  }

  Future<void> _signInWithEmailAndPassword(
      String email, String password) async {
    try {
      isLoading.value = true; // Set isLoading to true

      UserCredential? user =
          await AuthService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        // Wait for a short duration to simulate loading time (optional)
        await Future.delayed(const Duration(seconds: 2));

        Get.to(BottomBarPage());
      } else {
        showToast("Invalid email or password.");
      }
    } catch (e) {
      showToast("An error occurred. Please try again later.");
      print("Login Error: $e");
    } finally {
      isLoading.value = false; // Set isLoading to false after completion
    }
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

  String format(String st) {
    return st.trim();
  }
}
